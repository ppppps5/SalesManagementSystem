<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<script type="text/javascript">
	
	// 초기화
	$(document).ready(function () {
		
	});
	
	function sales2Chart11(resultJson) {
		console.log('resultJson >>>>> ' + resultJson);
		//var goal = "KRW";
		//console.log('goal >>>>> ' + goal);
		var chart11 = AmCharts.makeChart("chart11", {

			"type" 			: "serial",
			
			"theme" 		: "light",
			
			"dataProvider" 	: resultJson,
			
			"valueAxes" : [ {
				"minimum": 0,
				"axisAlpha": 0,
				//"axisAlpha" : 0,
				"position": "left"
			} ],
			 
			"startDuration" : 1,

			 "graphs": [
			    {
				    "balloonText": "<b>[[category]]전체목표: [[value]] </b>",
				    "fillColorsField": "color1",
				    "fillAlphas": 0.9,
				    "lineAlpha": 0.2,
				    "type": "column",
				    "valueField": "totGoal"
			 	},
			 	{
				    "balloonText": "<b>[[category]]전체실적: [[value]] </b>",
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
			
			"categoryField" : "month",
			
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