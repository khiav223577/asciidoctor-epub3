# frozen_string_literal: true

require_relative 'lib/asciidoctor-epub3/version'
require 'open3' unless defined? Open3

Gem::Specification.new do |s|
  s.name = 'asciidoctor-epub3'
  s.version = Asciidoctor::Epub3::VERSION

  s.summary = 'Converts AsciiDoc documents to EPUB3 and KF8/MOBI (Kindle) e-book formats'
  s.description = <<-EOS
An extension for Asciidoctor that converts AsciiDoc documents to EPUB3 and KF8/MOBI (Kindle) e-book archives.
  EOS

  s.authors = ['Dan Allen', 'Sarah White']
  s.email = 'dan@opendevise.com'
  s.homepage = 'https://github.com/asciidoctor/asciidoctor-epub3'
  s.license = 'MIT'

  s.required_ruby_version = '>= 2.3.0'

  files = begin
    (result = Open3.popen3('git ls-files -z') {|_, out| out.read }.split %(\0)).empty? ? Dir['**/*'] : result
  rescue
    Dir['**/*']
  end
  s.files = files.grep %r/^(?:(?:data\/(?:fonts|images|styles)|lib)\/.+|Gemfile|Rakefile|(?:CHANGELOG|LICENSE|NOTICE|README)\.adoc|\.yardopts|#{s.name}\.gemspec)$/
  s.executables = %w(asciidoctor-epub3 adb-push-ebook)
  s.test_files = s.files.grep(/^(?:test|spec|feature)\/.*$/)

  s.require_paths = ['lib']

  s.add_development_dependency 'rake', '~> 13.0.0'
  s.add_development_dependency 'rspec', '~> 3.9.0'
  s.add_development_dependency 'rubocop', '~> 0.79.0'
  s.add_development_dependency 'rubocop-rspec', '~> 1.37.0'

  s.add_runtime_dependency 'asciidoctor', '>= 1.5.3', '< 3.0.0'
  s.add_runtime_dependency 'epubcheck-ruby', '~> 4.2.2.0'
  s.add_runtime_dependency 'gepub', '~> 1.0.0'
  s.add_runtime_dependency 'kindlegen', '>= 3.0.3', '<= 3.0.5'
end
