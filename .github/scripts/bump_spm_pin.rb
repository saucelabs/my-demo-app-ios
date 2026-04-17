#!/usr/bin/env ruby
# Usage: bump_spm_pin.rb <package-name-substring> <new-minimum-version>
#
# Updates the XCRemoteSwiftPackageReference whose repositoryURL contains
# <package-name-substring>, setting its requirement.minimumVersion to
# <new-minimum-version>. Saves project.pbxproj in place.
#
# Run from the directory containing the .xcodeproj bundle, or set
# PBXPROJ_PATH to the .xcodeproj path.

require 'xcodeproj'

abort "usage: #{$0} <package-name-substring> <new-minimum-version>" if ARGV.length != 2

needle, new_version = ARGV
project_path = ENV['PBXPROJ_PATH'] || Dir.glob('*.xcodeproj').sort.first
abort "no .xcodeproj found in #{Dir.pwd}; set PBXPROJ_PATH" unless project_path

project = Xcodeproj::Project.open(project_path)
refs = project.root_object.package_references.select do |r|
  r.isa == 'XCRemoteSwiftPackageReference' && r.repositoryURL.to_s.include?(needle)
end

abort "no XCRemoteSwiftPackageReference matches #{needle.inspect}" if refs.empty?
abort "multiple references match #{needle.inspect}; be more specific" if refs.size > 1

ref = refs.first
old = ref.requirement['minimumVersion']

if old == new_version
  puts "already at #{new_version}; no change"
  exit 0
end

ref.requirement = ref.requirement.merge('minimumVersion' => new_version)
project.save

puts "bumped #{ref.repositoryURL}: #{old} -> #{new_version}"
