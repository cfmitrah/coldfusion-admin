<cfoutput>

<div class="mt-medium" id="theme-rolling">
	<div class="container-fluid">
		<h3 class="form-section-title">Choose a starting point for a new theme or edit the current one</h3>

		<div class="palette-wrap" id="current_theme">
			<p class="theme-name">Edit Current Theme</p>
			<a href="##" data-theme="current" class="cf palette blank-canvas">
				<span class="a"></span>
				<span class="b"></span>
				<span class="c"></span>
				<span class="d"></span>
				<span class="e"></span>
				<i class="glyphicon glyphicon-chevron-right"></i>
			</a>
		</div>

		<div class="palette-wrap">
			<p class="theme-name">Beach Sunset</p>
			<a href="##" data-toggle="modal" data-target="##bs" class="btn btn-md btn-default">View Theme Preview</a>
			<a href="##" data-theme="beach_sunset" class="cf palette beach-sunset">
				<span class="a"></span>
				<span class="b"></span>
				<span class="c"></span>
				<span class="d"></span>
				<span class="e"></span>
				<i class="glyphicon glyphicon-chevron-right"></i>
			</a>
		</div>

		<div class="palette-wrap">
			<p class="theme-name">To The Point</p>
			<a href="##" data-toggle="modal" data-target="##ttp" class="btn btn-md btn-default">View Theme Preview</a>
			<a href="##" data-theme="to_the_point" class="cf palette to-the-point">
				<span class="a"></span>
				<span class="b"></span>
				<span class="c"></span>
				<span class="d"></span>
				<span class="e"></span>
				<i class="glyphicon glyphicon-chevron-right"></i>
			</a>
		</div>

		<div class="palette-wrap">
			<p class="theme-name">Coffee Shop</p>
			<a href="##" data-toggle="modal" data-target="##cs" class="btn btn-md btn-default">View Theme Preview</a>
			<a href="##" data-theme="coffee_shop" class="cf palette coffee-shop">
				<span class="a"></span>
				<span class="b"></span>
				<span class="c"></span>
				<span class="d"></span>
				<span class="e"></span>
				<i class="glyphicon glyphicon-chevron-right"></i>
			</a>
		</div>

		<div class="palette-wrap">
			<p class="theme-name">Electric Night</p>
			<a href="##" data-toggle="modal" data-target="##en" class="btn btn-md btn-default">View Theme Preview</a>
			<a href="##" data-theme="electric_night" class="cf palette electric-night">
				<span class="a"></span>
				<span class="b"></span>
				<span class="c"></span>
				<span class="d"></span>
				<span class="e"></span>
				<i class="glyphicon glyphicon-chevron-right"></i>
			</a>
		</div>

		<div class="palette-wrap">
			<p class="theme-name">Jungle Safari</p>
			<a href="##" data-toggle="modal" data-target="##js" class="btn btn-md btn-default">View Theme Preview</a>
			<a href="##" data-theme="jungle_safari" class="cf palette jungle-safari">
				<span class="a"></span>
				<span class="b"></span>
				<span class="c"></span>
				<span class="d"></span>
				<span class="e"></span>
				<i class="glyphicon glyphicon-chevron-right"></i>
			</a>
		</div>
	</div>
</div>
</cfoutput>

<div class="modal fade" id="bs" tabindex="-1" role="dialog" aria-labelledby="bsLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="bsLabel">Beach Sunset Theme Preview</h4>
			</div>
			<div class="modal-body">
				<img src="/assets/img/themes/beach-sunset.png" class="img-responsive" alt="">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="ttp" tabindex="-1" role="dialog" aria-labelledby="ttpLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="ttpLabel">To The Point Theme Preview</h4>
			</div>
			<div class="modal-body">
				<img src="/assets/img/themes/to-the-point.png" class="img-responsive" alt="">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="cs" tabindex="-1" role="dialog" aria-labelledby="csLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="csLabel">Coffee Shop Theme Preview</h4>
			</div>
			<div class="modal-body">
				<img src="/assets/img/themes/coffee-shop.png" class="img-responsive" alt="">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="en" tabindex="-1" role="dialog" aria-labelledby="enLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="enLabel">Electric Night Theme Preview</h4>
			</div>
			<div class="modal-body">
				<img src="/assets/img/themes/electric-night.png" class="img-responsive" alt="">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="js" tabindex="-1" role="dialog" aria-labelledby="jsLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="jsLabel">Jungle Safari Theme Preview</h4>
			</div>
			<div class="modal-body">
				<img src="/assets/img/themes/jungle-safari.png" class="img-responsive" alt="">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div> 