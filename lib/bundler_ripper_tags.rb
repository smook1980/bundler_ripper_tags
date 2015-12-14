require 'bundler_ripper_tags/version'
require 'bundler_ripper_tags/bundle_gem_finder'
require 'bundler_ripper_tags/command_builder'

module BundlerRipperTags
  def self.run!
    gem_info = BundleGemFinder.new
    cmd = CommandBuilder.new(
      src_root: gem_info.gemfile_path,
      gem_paths: gem_info.to_a)

    cmd.execute
  end
end
