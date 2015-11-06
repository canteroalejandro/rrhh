/* Flot plugin for rendering pie charts.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

The plugin assumes that each series has a single data value, and that each
value is a positive integer or zero.  Negative numbers don't make sense for a
pie chart, and have unpredictable results.  The values do NOT need to be
passed in as percentages; the plugin will calculate the total and per-slice
percentages internally.

* Created by Brian Medendorp

* Updated with contributions from btburnett3, Anthony Aragues and Xavi Ivars

The plugin supports these options:

	series: {
		pie: {
			show: true/false
			radius: 0-1 for percentage of fullsize, or a specified pixel length, or 'auto'
			innerRadius: 0-1 for percentage of fullsize or a specified pixel length, for creating a donut effect
			startAngle: 0-2 factor of PI used for starting angle (in radians) i.e 3/2 starts at the top, 0 and 2 have the same result
			tilt: 0-1 for percentage to tilt the pie, where 1 is no tilt, and 0 is completely flat (nothing will show)
			offset: {
				top: integer value to move the pie up or down
				left: integer value to move the pie left or right, or 'auto'
			},
			stroke: {
				color: any hexidecimal color value (other formats may or may not work, so best to stick with something like '#FFF')
				width: integer pixel width of the stroke
			},
			label: {
				show: true/false, or 'auto'
				formatter:  a user-defined function that modifies the text/style of the label text
				radius: 0-1 for percentage of fullsize, or a specified pixel length
				background: {
					color: any hexidecimal color value (other formats may or may not work, so best to stick with something like '#000')
					opacity: 0-1
				},
				threshold: 0-1 for the percentage value at which to hide labels (if they're too small)
			},
			combine: {
				threshold: 0-1 for the percentage value at which to combine slices (if they're too small)
				color: any hexidecimal color value (other formats may or may not work, so best to stick with something like '#CCC'), if null, the plugin will automatically use the color of the first slice to be combined
				label: any text value of what the combined slice should be labeled
			}
			highlight: {
				opacity: 0-1
			}
		}
	}

More detail and specific examples can be found in the included HTML file.

*/
!function(t){function e(e){function o(e,i,n){_||(_=!0,y=e.getCanvas(),x=t(y).parent(),s=e.getOptions(),e.setData(r(e.getData())))}function r(e){for(var i=0,n=0,o=0,r=s.series.pie.combine.color,a=[],l=0;l<e.length;++l){var h=e[l].data;t.isArray(h)&&1==h.length&&(h=h[0]),t.isArray(h)?!isNaN(parseFloat(h[1]))&&isFinite(h[1])?h[1]=+h[1]:h[1]=0:h=!isNaN(parseFloat(h))&&isFinite(h)?[1,+h]:[1,0],e[l].data=[h]}for(var l=0;l<e.length;++l)i+=e[l].data[0][1];for(var l=0;l<e.length;++l){var h=e[l].data[0][1];h/i<=s.series.pie.combine.threshold&&(n+=h,o++,r||(r=e[l].color))}for(var l=0;l<e.length;++l){var h=e[l].data[0][1];(2>o||h/i>s.series.pie.combine.threshold)&&a.push({data:[[1,h]],color:e[l].color,label:e[l].label,angle:h*Math.PI*2/i,percent:h/(i/100)})}return o>1&&a.push({data:[[1,n]],color:r,label:s.series.pie.combine.label,angle:n*Math.PI*2/i,percent:n/(i/100)}),a}function a(e,o){function r(){k.clearRect(0,0,c,u),x.children().filter(".pieLabel, .pieLabelBackground").remove()}function a(){var t=s.series.pie.shadow.left,e=s.series.pie.shadow.top,i=10,n=s.series.pie.shadow.alpha,o=s.series.pie.radius>1?s.series.pie.radius:b*s.series.pie.radius;if(!(o>=c/2-t||o*s.series.pie.tilt>=u/2-e||i>=o)){k.save(),k.translate(t,e),k.globalAlpha=n,k.fillStyle="#000",k.translate(w,C),k.scale(1,s.series.pie.tilt);for(var r=1;i>=r;r++)k.beginPath(),k.arc(0,0,o,0,2*Math.PI,!1),k.fill(),o-=r;k.restore()}}function h(){function e(t,e,i){0>=t||isNaN(t)||(i?k.fillStyle=e:(k.strokeStyle=e,k.lineJoin="round"),k.beginPath(),Math.abs(t-2*Math.PI)>1e-9&&k.moveTo(0,0),k.arc(0,0,o,r,r+t/2,!1),k.arc(0,0,o,r+t/2,r+t,!1),k.closePath(),r+=t,i?k.fill():k.stroke())}function i(){function e(e,i,n){if(0==e.data[0][1])return!0;var r,a=s.legend.labelFormatter,l=s.series.pie.label.formatter;r=a?a(e.label,e):e.label,l&&(r=l(r,e));var h=(i+e.angle+i)/2,p=w+Math.round(Math.cos(h)*o),f=C+Math.round(Math.sin(h)*o)*s.series.pie.tilt,d="<span class='pieLabel' id='pieLabel"+n+"' style='position:absolute;top:"+f+"px;left:"+p+"px;'>"+r+"</span>";x.append(d);var g=x.children("#pieLabel"+n),m=f-g.height()/2,v=p-g.width()/2;if(g.css("top",m),g.css("left",v),0-m>0||0-v>0||u-(m+g.height())<0||c-(v+g.width())<0)return!1;if(0!=s.series.pie.label.background.opacity){var y=s.series.pie.label.background.color;null==y&&(y=e.color);var b="top:"+m+"px;left:"+v+"px;";t("<div class='pieLabelBackground' style='position:absolute;width:"+g.width()+"px;height:"+g.height()+"px;"+b+"background-color:"+y+";'></div>").css("opacity",s.series.pie.label.background.opacity).insertBefore(g)}return!0}for(var i=n,o=s.series.pie.label.radius>1?s.series.pie.label.radius:b*s.series.pie.label.radius,r=0;r<f.length;++r){if(f[r].percent>=100*s.series.pie.label.threshold&&!e(f[r],i,r))return!1;i+=f[r].angle}return!0}var n=Math.PI*s.series.pie.startAngle,o=s.series.pie.radius>1?s.series.pie.radius:b*s.series.pie.radius;k.save(),k.translate(w,C),k.scale(1,s.series.pie.tilt),k.save();for(var r=n,a=0;a<f.length;++a)f[a].startAngle=r,e(f[a].angle,f[a].color,!0);if(k.restore(),s.series.pie.stroke.width>0){k.save(),k.lineWidth=s.series.pie.stroke.width,r=n;for(var a=0;a<f.length;++a)e(f[a].angle,s.series.pie.stroke.color,!1);k.restore()}return l(k),k.restore(),s.series.pie.label.show?i():!0}if(x){var c=e.getPlaceholder().width(),u=e.getPlaceholder().height(),p=x.children().filter(".legend").children().width()||0;k=o,_=!1,b=Math.min(c,u/s.series.pie.tilt)/2,C=u/2+s.series.pie.offset.top,w=c/2,"auto"==s.series.pie.offset.left?s.legend.position.match("w")?w+=p/2:w-=p/2:w+=s.series.pie.offset.left,b>w?w=b:w>c-b&&(w=c-b);var f=e.getData(),d=0;do d>0&&(b*=n),d+=1,r(),s.series.pie.tilt<=.8&&a();while(!h()&&i>d);d>=i&&(r(),x.prepend("<div class='error'>Could not draw pie with labels contained inside canvas</div>")),e.setSeries&&e.insertLegend&&(e.setSeries(f),e.insertLegend())}}function l(t){if(s.series.pie.innerRadius>0){t.save();var e=s.series.pie.innerRadius>1?s.series.pie.innerRadius:b*s.series.pie.innerRadius;t.globalCompositeOperation="destination-out",t.beginPath(),t.fillStyle=s.series.pie.stroke.color,t.arc(0,0,e,0,2*Math.PI,!1),t.fill(),t.closePath(),t.restore(),t.save(),t.beginPath(),t.strokeStyle=s.series.pie.stroke.color,t.arc(0,0,e,0,2*Math.PI,!1),t.stroke(),t.closePath(),t.restore()}}function h(t,e){for(var i=!1,n=-1,s=t.length,o=s-1;++n<s;o=n)(t[n][1]<=e[1]&&e[1]<t[o][1]||t[o][1]<=e[1]&&e[1]<t[n][1])&&e[0]<(t[o][0]-t[n][0])*(e[1]-t[n][1])/(t[o][1]-t[n][1])+t[n][0]&&(i=!i);return i}function c(t,i){for(var n,s,o=e.getData(),r=e.getOptions(),a=r.series.pie.radius>1?r.series.pie.radius:b*r.series.pie.radius,l=0;l<o.length;++l){var c=o[l];if(c.pie.show){if(k.save(),k.beginPath(),k.moveTo(0,0),k.arc(0,0,a,c.startAngle,c.startAngle+c.angle/2,!1),k.arc(0,0,a,c.startAngle+c.angle/2,c.startAngle+c.angle,!1),k.closePath(),n=t-w,s=i-C,k.isPointInPath){if(k.isPointInPath(t-w,i-C))return k.restore(),{datapoint:[c.percent,c.data],dataIndex:0,series:c,seriesIndex:l}}else{var u=a*Math.cos(c.startAngle),p=a*Math.sin(c.startAngle),f=a*Math.cos(c.startAngle+c.angle/4),d=a*Math.sin(c.startAngle+c.angle/4),g=a*Math.cos(c.startAngle+c.angle/2),m=a*Math.sin(c.startAngle+c.angle/2),v=a*Math.cos(c.startAngle+c.angle/1.5),y=a*Math.sin(c.startAngle+c.angle/1.5),x=a*Math.cos(c.startAngle+c.angle),_=a*Math.sin(c.startAngle+c.angle),S=[[0,0],[u,p],[f,d],[g,m],[v,y],[x,_]],T=[n,s];if(h(S,T))return k.restore(),{datapoint:[c.percent,c.data],dataIndex:0,series:c,seriesIndex:l}}k.restore()}}return null}function u(t){f("plothover",t)}function p(t){f("plotclick",t)}function f(t,i){var n=e.offset(),o=parseInt(i.pageX-n.left),r=parseInt(i.pageY-n.top),a=c(o,r);if(s.grid.autoHighlight)for(var l=0;l<S.length;++l){var h=S[l];h.auto==t&&(!a||h.series!=a.series)&&g(h.series)}a&&d(a.series,t);var u={pageX:i.pageX,pageY:i.pageY};x.trigger(t,[u,a])}function d(t,i){var n=m(t);-1==n?(S.push({series:t,auto:i}),e.triggerRedrawOverlay()):i||(S[n].auto=!1)}function g(t){null==t&&(S=[],e.triggerRedrawOverlay());var i=m(t);-1!=i&&(S.splice(i,1),e.triggerRedrawOverlay())}function m(t){for(var e=0;e<S.length;++e){var i=S[e];if(i.series==t)return e}return-1}function v(t,e){function i(t){t.angle<=0||isNaN(t.angle)||(e.fillStyle="rgba(255, 255, 255, "+n.series.pie.highlight.opacity+")",e.beginPath(),Math.abs(t.angle-2*Math.PI)>1e-9&&e.moveTo(0,0),e.arc(0,0,s,t.startAngle,t.startAngle+t.angle/2,!1),e.arc(0,0,s,t.startAngle+t.angle/2,t.startAngle+t.angle,!1),e.closePath(),e.fill())}var n=t.getOptions(),s=n.series.pie.radius>1?n.series.pie.radius:b*n.series.pie.radius;e.save(),e.translate(w,C),e.scale(1,n.series.pie.tilt);for(var o=0;o<S.length;++o)i(S[o].series);l(e),e.restore()}var y=null,x=null,b=null,w=null,C=null,_=!1,k=null,S=[];e.hooks.processOptions.push(function(t,e){e.series.pie.show&&(e.grid.show=!1,"auto"==e.series.pie.label.show&&(e.legend.show?e.series.pie.label.show=!1:e.series.pie.label.show=!0),"auto"==e.series.pie.radius&&(e.series.pie.label.show?e.series.pie.radius=.75:e.series.pie.radius=1),e.series.pie.tilt>1?e.series.pie.tilt=1:e.series.pie.tilt<0&&(e.series.pie.tilt=0))}),e.hooks.bindEvents.push(function(t,e){var i=t.getOptions();i.series.pie.show&&(i.grid.hoverable&&e.unbind("mousemove").mousemove(u),i.grid.clickable&&e.unbind("click").click(p))}),e.hooks.processDatapoints.push(function(t,e,i,n){var s=t.getOptions();s.series.pie.show&&o(t,e,i,n)}),e.hooks.drawOverlay.push(function(t,e){var i=t.getOptions();i.series.pie.show&&v(t,e)}),e.hooks.draw.push(function(t,e){var i=t.getOptions();i.series.pie.show&&a(t,e)})}var i=10,n=.95,s={series:{pie:{show:!1,radius:"auto",innerRadius:0,startAngle:1.5,tilt:1,shadow:{left:5,top:15,alpha:.02},offset:{top:0,left:"auto"},stroke:{color:"#fff",width:1},label:{show:"auto",formatter:function(t,e){return"<div style='font-size:x-small;text-align:center;padding:2px;color:"+e.color+";'>"+t+"<br/>"+Math.round(e.percent)+"%</div>"},radius:1,background:{color:null,opacity:0},threshold:0},combine:{threshold:-1,color:null,label:"Other"},highlight:{opacity:.5}}}};t.plot.plugins.push({init:e,options:s,name:"pie",version:"1.1"})}(jQuery);