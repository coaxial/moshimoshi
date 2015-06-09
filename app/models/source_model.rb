class Source
  def initialize(uri)
    @uri = uri
  end

  def delete
    File.delete(pathname)
  end

  def pathname
    match = @uri.match(/file:\/\/(.+)/)
    match[1] if match
  end
end
