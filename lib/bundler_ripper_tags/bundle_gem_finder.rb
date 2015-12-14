require 'bundler'

module BundlerRipperTags
  class BundleGemFinder
    include Enumerable

    attr_reader :gemfile_path

    def initialize(groups: [:default, :development, :test])
      bundler = Bundler.setup(*groups)
      @gemfile_path = bundler.root
      @specs = bundler.specs
    end

    def each(&block)
      paths.each { |p| block.call(p) }
    end

    private

    def paths
      @paths ||= @specs.map    { |spec| spec.gem_dir }
                       .reject { |gem_dir| gem_dir.nil? || gem_dir.empty? }
                       .map    { |gem_dir| Pathname(gem_dir) }
                       .select { |gem_path| gem_path.directory? }
                       .map(&:realpath)
                       .map(&:to_s)
    end
  end
end
