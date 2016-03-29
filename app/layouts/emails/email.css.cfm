 		<style type="text/css">
			#outlook a{padding:0;} /* Force Outlook to provide a "view in browser" button. */
			body{width:100% !important;} .ReadMsgBody{width:100%;} .ExternalClass{width:100%;} /* Force Hotmail to display emails at full width */
			body{-webkit-text-size-adjust:none;} /* Prevent Webkit platforms from changing default text sizes. */

			/* Reset Styles */
			body{margin:0; padding:0;}
			img{border:0; height:auto; line-height:100%; outline:none; text-decoration:none;}
			table td{border-collapse:collapse;}
			#backgroundTable{height:100% !important; margin:0; padding:0; width:100% !important;}

			/* /\/\/\/\/\/\/\/\/\/\ STANDARD STYLING: COMMON PAGE ELEMENTS /\/\/\/\/\/\/\/\/\/\ */

			body, #backgroundTable{
				background-color:#FAFAFA;
			}

			
			#templateContainer{
				border: 1px solid #DDDDDD;
			}

			h1, .h1{
				color:#202020;
				display:block;
				font-family:Arial;
				font-size:34px;
				font-weight:bold;
				line-height:100%;
				margin-top:0;
				margin-right:0;
				margin-bottom:10px;
				margin-left:0;
				text-align:left;
			}

			h2, .h2{
				color:#202020;
				display:block;
				font-family:Arial;
				font-size:30px;
				font-weight:bold;
				line-height:100%;
				margin-top:0;
				margin-right:0;
				margin-bottom:10px;
				margin-left:0;
				text-align:left;
			}

			h3, .h3{
				color:#202020;
				display:block;
				font-family:Arial;
				font-size:26px;
				font-weight:bold;
				line-height:100%;
				margin-top:0;
				margin-right:0;
				margin-bottom:10px;
				margin-left:0;
				text-align:left;
			}

			h4, .h4{
				color:#202020;
				display:block;
				font-family:Arial;
				font-size:22px;
				font-weight:bold;
				line-height:100%;
				margin-top:0;
				margin-right:0;
				margin-bottom:10px;
				margin-left:0;
				text-align:left;
			}

			/* /\/\/\/\/\/\/\/\/\/\ STANDARD STYLING: HEADER /\/\/\/\/\/\/\/\/\/\ */

			#templateHeader{
				background-color:#FFFFFF;
				border-bottom:0;
			}

			.headerContent{
				color:#202020;
				font-family:Arial;
				font-size:34px;
				font-weight:bold;
				line-height:100%;
				padding:0;
				text-align:center;
				vertical-align:middle;
			}

			.headerContent a:link, .headerContent a:visited, /* Yahoo! Mail Override */ .headerContent a .yshortcuts /* Yahoo! Mail Override */{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}

			#headerImage{
				height:auto;
				max-width:600px !important;
			}

			#templateContainer, .bodyContent{
				background-color:#FFFFFF;
			}

			.bodyContent div{
				color:#505050;
				font-family:Arial;
				font-size:14px;
				line-height:150%;
				text-align:left;
			}

			.bodyContent div a:link, .bodyContent div a:visited, /* Yahoo! Mail Override */ .bodyContent div a .yshortcuts /* Yahoo! Mail Override */{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}

			.bodyContent img{
				display:inline;
				height:auto;
			}

			/* /\/\/\/\/\/\/\/\/\/\ STANDARD STYLING: FOOTER /\/\/\/\/\/\/\/\/\/\ */

			#templateFooter{
				background-color:#FFFFFF;
				border-top:0;
			}

			.footerContent div{
				color:#707070;
				font-family:Arial;
				font-size:12px;
				line-height:125%;
				text-align:left;
			}

			.footerContent div a:link, .footerContent div a:visited, /* Yahoo! Mail Override */ .footerContent div a .yshortcuts /* Yahoo! Mail Override */{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}

			.footerContent img{
				display:inline;
			}

			.table {
			  width: 100%;
			  max-width: 100%;
			  margin-bottom: 20px;
			}
			.table > thead > tr > th,
			.table > tbody > tr > th,
			.table > tfoot > tr > th,
			.table > thead > tr > td,
			.table > tbody > tr > td,
			.table > tfoot > tr > td {
			  padding: 8px;
			  line-height: 1.42857143;
			  vertical-align: top;
			  border-top: 1px solid #ddd;
			}
			.table > thead > tr > th {
			  vertical-align: bottom;
			  border-bottom: 2px solid #ddd;
			}
			.table > caption + thead > tr:first-child > th,
			.table > colgroup + thead > tr:first-child > th,
			.table > thead:first-child > tr:first-child > th,
			.table > caption + thead > tr:first-child > td,
			.table > colgroup + thead > tr:first-child > td,
			.table > thead:first-child > tr:first-child > td {
			  border-top: 0;
			}
			.table > tbody + tbody {
			  border-top: 2px solid #ddd;
			}
			.table .table {
			  background-color: #fff;
			}
			.table-condensed > thead > tr > th,
			.table-condensed > tbody > tr > th,
			.table-condensed > tfoot > tr > th,
			.table-condensed > thead > tr > td,
			.table-condensed > tbody > tr > td,
			.table-condensed > tfoot > tr > td {
			  padding: 5px;
			}
			.table-bordered {
			  border: 1px solid #ddd;
			}
			.table-bordered > thead > tr > th,
			.table-bordered > tbody > tr > th,
			.table-bordered > tfoot > tr > th,
			.table-bordered > thead > tr > td,
			.table-bordered > tbody > tr > td,
			.table-bordered > tfoot > tr > td {
			  border: 1px solid #ddd;
			}
			.table-bordered > thead > tr > th,
			.table-bordered > thead > tr > td {
			  border-bottom-width: 2px;
			}
			.table-striped > tbody > tr:nth-child(odd) {
			  background-color: #f9f9f9;
			}
			.table-hover > tbody > tr:hover {
			  background-color: #f5f5f5;
			}
			table col[class*="col-"] {
			  position: static;
			  display: table-column;
			  float: none;
			}
			table td[class*="col-"],
			table th[class*="col-"] {
			  position: static;
			  display: table-cell;
			  float: none;
			}
			.table > thead > tr > td.active,
			.table > tbody > tr > td.active,
			.table > tfoot > tr > td.active,
			.table > thead > tr > th.active,
			.table > tbody > tr > th.active,
			.table > tfoot > tr > th.active,
			.table > thead > tr.active > td,
			.table > tbody > tr.active > td,
			.table > tfoot > tr.active > td,
			.table > thead > tr.active > th,
			.table > tbody > tr.active > th,
			.table > tfoot > tr.active > th {
			  background-color: #f5f5f5;
			}
			.table-hover > tbody > tr > td.active:hover,
			.table-hover > tbody > tr > th.active:hover,
			.table-hover > tbody > tr.active:hover > td,
			.table-hover > tbody > tr:hover > .active,
			.table-hover > tbody > tr.active:hover > th {
			  background-color: #e8e8e8;
			}
			
			.table-responsive {
			  min-height: .01%;
			  overflow-x: auto;
			}
						
		</style>
