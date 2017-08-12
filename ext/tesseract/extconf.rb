require 'mkmf'
require 'pathname'

find_executable('make')

root = File.expand_path('../../..', __FILE__)

# Create a dummy extension file. Without this RubyGems would abort the
# installation process. On Linux this would result in the file "tesseract.so"
# being created in the current working directory.
#
# Normally the generated Makefile would take care of this but since we
# don't generate one we'll have to do this manually.
#
dummy_extension = File.join(File.dirname(__FILE__), "tesseract.#{RbConfig::CONFIG['DLEXT']}")
File.open(dummy_extension, "w") {}

Dir.chdir(File.join(root, 'vendor/tesseract')) do
  system "./autogen.sh"
  system "./configure --prefix=#{root} --disable-graphics --disable-dependency-tracking"
  system "make && make install && make clean"
end

# This is normally set by calling create_makefile() but we don't need that
# method since we'll provide a dummy Makefile. Without setting this value
# RubyGems will abort the installation.
$makefile_created = true
