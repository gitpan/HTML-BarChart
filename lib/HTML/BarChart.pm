package HTML::BarChart;
sub new {
	shift;
	my $this = {};
	$this->{Output} = undef;
	$this->{Values} = undef;
	$this->{Colors} = undef;
	$this->{Height} = undef;
	$this->{Width} = undef;
	$this->{Largst} = undef;
	$this->{Cols} = undef;
	$this->{Titles} = undef;
	bless($this);
	my ($Title,$Width,$Height,$Border) = (shift,shift,shift,shift);
	$Border = '#000000' if (!defined($Border));
	$this->{Cols} = 1;
	$this->{Output} = <<BEGIN;
	<table bgcolor="$Border" width="$Width" height="$Height" border="0" cellpadding="0" cellspacing="1"><tr>
		<td colspan="%#COLS#%">
	<table border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF" width="100%">
	<tr><td valign="top" align="center"><font size="2" face="Arial">
$Title
	</td></tr></table>
</td></tr><tr><td colspan="%#COLS#%" align="center"><table bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="0" width="100%"><tr>
BEGIN
	$this->{Width} = $Width;
	$this->{Height} = $Height;
	return $this;
}
sub bar {
	my ($this,$Title,$Height,$Color) = (shift,shift,shift,shift);
	push(@{$this->{Titles}},$Title);
	$this->{Cols}++;
	$Color = '#AAAA99' if (!defined($Color));
	push(@{$this->{Values}},$Height);
	push(@{$this->{Colors}},$Color);
	$this->{Largst} = $Height if ($Height > $this->{Largst});
	return $this;
}
sub render {
	my $this = shift;
	my $Ratio = $this->{Height} / $this->{Largst};
	my $Width = $this->{Width} / ($#{$this->{Values}} + 1);
	my ($Stick,$Color,$Height);
	while ($Stick = shift(@{$this->{Values}})) {
		$Color = shift(@{$this->{Colors}});
		$Height = $Stick * $Ratio;
		$this->{Output} .= <<BAR;

	<td valign="bottom" align="center" width="100">
		<table height="$Height" width="$Width" bgcolor="$Color" cellpadding="1" cellspacing="1">
		<tr><td></tr></td></table>
	</td>
BAR
	}
	return $this;
}
sub return {
	my $this = shift;
	my $Title;
	$this->render;
	$this->{Output} .= '</tr></table></td></tr><tr>';
	while ($Title = shift(@{$this->{Titles}})) {
		$this->{Output} .= <<END;
<td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF"><tr>
	<td align="center"><font size="1" face="Arial">$Title</font></td></tr></table></td>	
END
	}
	$this->{Output} .= '</tr></table>';
	$this->{Output} =~ s/\%\#COLS\#\%/$this->{Cols}/g;
	return $this->{Output};
}
sub draw {
	$this = shift;
	print $this->return;
}
1;

=head1 NAME

HTML::BarChart - Class that generates Bar Charts in HTML 

=head1 SYNOPSIS

 use HTML::BarChart;
 my ($Width,$Height) = (300,100);
 $Chart = HTML::BarChart->new("HTML::BarChart Example", $Width, $Height);
 $Chart->bar("LABEL1",115,"#BBBBAA"); # Label, PlotValue, Color
 $Chart->bar("LABEL2",212,"#AAAA99");
 $Chart->bar("LABEL3",89,"#999988");
 $Chart->bar("LABEL4",256,"#888877");

 $Chart->draw;

=head1 DESCRIPTION

Generates Bar Charts with HTML Tables from input, All ratio calculation is done
by the module.  Its really a very simple package.

The following methods are available:

=over 4

=item $Chart = HTML::BarChart->new($title, $width, $height, [ $bordercolor ]) 

Creates new HTML::BarChart Object with specified $width and specified $height
Places $title in the titlebar

=item $Chart->bar($label, $value, [ $color ])

Plots point on the BarChart, $value being relative to the largest value passed
prior to calling $Chart->return and the $height passed in HTML::BarChart->new

=item $FinishedProduct = $Chart->return

Renders the HTML and gives it as return value, this is usefull for if you are
actually using another module for output and wish to pass the char through as
a paramater.

=item $Chart->draw

Simply calls print $Chart->return, printing the resulting chart to standard
output. 

