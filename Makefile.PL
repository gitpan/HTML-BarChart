use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
		'NAME'      => 'HTML::BarChart',
		'VERSION'   => '0.1.0',
#		'PM'    =>  {
#		'HTML/BarChart.pm'        => '$(INST_LIBDIR)/BarChart.pm',
#		},

		'dist' => {COMPRESS => 'gzip -9', SUFFIX => 'gz'},
	     );

