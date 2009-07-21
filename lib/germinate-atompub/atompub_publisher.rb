require 'fattr'
require 'highline'
require 'atom/service'
require 'ick'

class GerminateAtompub::AtompubPublisher < Germinate::Publisher
  identifier "atompub"

  Ick::Returning.belongs_to(self)

  TEXT_PATH = File.expand_path('../text.yml', File.dirname(__FILE__))

  Q_DEFAULTS = lambda {|q| q.readline = true}

  fattr(:hl)          { HighLine.new }
  fattr(:text)        { File.open(TEXT_PATH) {|f| YAML.load(f)} }
  fattr(:http)        { 
    returning(Atom::HTTP.new) { |http| 
      http.user        = login
      http.pass        = password
      http.always_auth = :basic
    } 
  }
  fattr(:login)       { 
    librarian.variables.fetch('ATOMPUB_LOGIN') {
      hl.ask(text[:login], &Q_DEFAULTS)  
    }
  }
  fattr(:password)    { 
    hl.ask(text[:password]) {|q| 
      q.echo = "*" 
      q.readline = true
    }  
  }
  fattr(:service_url) { 
    hl.ask(text[:service_url]) {|q| 
      q.default = ENV['GERM_ATOM_SERVICE_URL'] 
    } 
  }
  fattr(:service)     { 
    begin
      Atom::Service.discover(service_url, http) 
    rescue Atom::Unauthorized
      hl.say "Authorization failed; please try again:"
      login!
      password!
      http!
      retry
    end
  }
  fattr(:collections)  { service.collections }
  fattr(:collection)  {
    if url = librarian.variables['ATOMPUB_COLLECTION_URL']
      Atom::Collection.new(url, http)
    else
      hl.say text[:collection]
      hl.choose { |m|
        m.readline = true
        collections.each do |c|
          m.choice(c.title) {c}
        end
      }
    end
  }
  fattr(:collection_url) { 
    librarian.variables.fetch('ATOMPUB_COLLECTION_URL') {
      collection.href 
    }
  }
  fattr(:entry) {
    if url = librarian.variables['ATOMPUB_ENTRY_URL']
      http.get_atom_entry(url)
    else
      returning(Atom::Entry.new) do |entry|
        entry.title           = librarian.source_path.to_s
        entry.draft           = true
      end
    end
  }

  def initialize(name, librarian, options={})
    super
  end

  def publish!(output=$stdout, extra_options = {})
    entry.content = input.join
    entry.content['type'] = 'html'
    entry.updated!

    response = if entry.edit_url
                 log.info "Updating entry at #{entry.edit_url}"
                 collection.put!(entry)
               else
                 log.info "Posting entry to #{collection.href}"
                 response  = collection.post!(entry)
               end
    log.debug "Response: #{response.inspect}"
    log.debug "Response body:\n #{response.read_body}"

    entry_url = entry.edit_url || response['Location']
    log.info "Posted/updated article at #{entry_url}"

    librarian.variables['ATOMPUB_ENTRY_URL'] = entry_url
    librarian.variables['ATOMPUB_COLLECTION_URL'] = collection_url
    librarian.variables['ATOMPUB_LOGIN'] = login
  end
end

