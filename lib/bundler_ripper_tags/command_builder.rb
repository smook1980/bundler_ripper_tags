require 'pathname'
require 'ripper-tags'

module BundlerRipperTags
  class CommandBuilder
    def initialize(src_root:, gem_paths:, options: {})
      @src_root = Pathname(src_root)
      @gem_paths = gem_paths
      @opts = build_opts(options)
    end

    def execute
      formatter.with_output do |out|
        reader.each_tag do |tag|
          formatter.write(tag, out)
        end
      end

      :success
    end

    private

    def build_opts(overrides)
      RipperTags.default_options.tap do |opts|
        opts.excluded = overrides.fetch(:excluded, ['tmp', 'log'])
        opts.recursive = true
        opts.tag_file_name = overrides.fetch(:tag_file_name, @src_root + 'TAGS')
        opts.files = @gem_paths.unshift(@src_root.realpath.to_s)
      end
    end

    def reader
      @reader ||= RipperTags::DataReader.new(@opts)
    end

    def formatter
      @formatter ||= RipperTags::EmacsFormatter.new(@opts)
    end
  end
end
