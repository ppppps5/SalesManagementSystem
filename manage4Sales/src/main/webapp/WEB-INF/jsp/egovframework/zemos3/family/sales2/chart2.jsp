<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<script type="text/javascript">
	
	// 초기화
	$(document).ready(function () {
		
	});
	
	function sales2Chart2(resultJson) {
		console.log('resultJson >>>>> ' + resultJson);
		var chart2 = AmCharts.makeChart("chart2", {

			"type" 			: "serial",
			
			"theme" 		: "light",
			
			"dataProvider" 	: resultJson,
			
			"valueAxes" : [ {
				"minimum": 0,
				"axisAlpha": 0,
				//"axisAlpha" : 0,
				"position" 	: "left"
			} ],
			
			"startDuration" : 1,
			  
			 "graphs": [{
				    "balloonText": "<b>[[category]]실적: [[value]] 원</b>",
				    "fillColorsField": "color2",
				    "fillAlphas": 0.9,
				    "lineAlpha": 0.2,
				    "type": "column",
				    "valueField": "totResult"
			 	}
			 ],
			
			"chartCursor" : {
				"categoryBalloonEnabled" 	: false,
				"cursorAlpha" 				: 0,
				"zoomable" 					: false
			},
			
			"categoryField" : "day",
			
			"categoryAxis" : {
				"gridPosition" 	: "start",
				"labelRotation" : 45
			},
			
			"export" : {
				"enabled" : true
			}

		});
	}
	
</script>