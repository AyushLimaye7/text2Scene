<%-- 
    Document   : letsdoit2
    Created on : 18 Mar, 2016, 1:55:04 PM
    Author     : mansi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>three.js webgl - io - OBJ converter</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
		<style>
			body {
				background:#fff;
				padding:0;
				margin:0;
				overflow:hidden;
				font-family:georgia;
				text-align:center;
			}
			h1 { }
			a { color:skyblue }

			#info { position:absolute; top:0px; width: 100%; text-align:center; }
			.button { background:#000; color:#fff; padding:0.2em 0.5em; cursor:pointer }
			.inactive { background:#999; color:#eee }
		</style>
		<script type= "text/javascript">
			function arrayDistribution()
			{

								
								var str = document.getElementById('obj_spa_obj').value;
								// an array variable that stores all
								//str = str.toLowerCase();
								//var res = str.split(" ");
								var res = str.split(" ");
								console.log(res);
								var obj1 = {type:"",x:0,y:0,z:0};
								var obj2 = {type:"",x:0,y:0,z:0};
								 obj1.type = res[0];
								var sptl = res[1];
	//							var count =0;
		//						if(res[1] == "inside" || res[1] == "outside" || res[1] == "beside" || res[1] == "on" || res[1] == "at" || res[1] == "top" ||  res[1] == "under" ||  res[1] == "left" ||  res[1] == "right" || res[1] == "back" || res[1] == "above")
			//					{
				//					count++; 
					//			}
								obj2.type = res[2];
								console.log(obj1.type , obj2.type);
								genericSpatial(obj1,sptl,obj2,res,0);
								genericSpatial(obj1,sptl,obj2,res,1);
								
			}
		
	function genericSpatial(obj1,sptl,obj2,res,count)
	{
		if(sptl == "inside")
		{
			obj2.x = obj1.x + 0;
			obj2.y = obj1.y + 0;
			obj2.z = obj1.z + 0;
		}
		else if(sptl == "outside")
		{
			obj2.x = obj1.x + 50;
			obj2.y = obj1.y + 0;
			obj2.z = obj1.z + 0;
		}
		else if(sptl == "on")
		{
			obj2.x = obj1.x + 0;
			obj2.y = obj1.y - 150;
			obj2.z = obj1.z + 0;
		}
		else if(sptl == "top")
		{
			obj2.x = obj1.x + 0;
			obj2.y = obj1.y - 150;
			obj2.z = obj1.z + 0;
		}
		else if(sptl == "at")
		{
			obj2.x = obj1.x + 0;
			obj2.y = obj1.y + 70;
			obj2.z = obj1.z + 0;
		}
		else if(sptl == "beside")
		{
			obj2.x = obj1.x + 100;
			obj2.y = obj1.y + 00;
			obj2.z = obj1.z + 0;
		}
		
		else if(sptl == "under")
		{
			obj2.x = obj1.x + 0;
			obj2.y = obj1.y - 150;
			obj2.z = obj1.z + 0;
		}	
		else if(sptl == "left")
		{
			obj2.x = obj1.x + 150;
			obj2.y = obj1.y + 0;
			obj2.z = obj1.z + 0;
		}
		else if(sptl == "right")
		{
			obj2.x = obj1.x - 150;
			obj2.y = obj1.y + 0;
			obj2.z = obj1.z + 0;
		}
		else if(sptl == "back")
		{
			obj2.x = obj1.x + 0;
			obj2.y = obj1.y + 0;
			obj2.z = obj1.z - 150;
		}
		else if(sptl == "above")
		{
			obj2.x = obj1.x + 0;
			obj2.y = obj1.y - 150;
			obj2.z = obj1.z + 0;
		}
		
		else if(sptl == "along")
		{
			obj2.x = obj1.x + 0;
			obj2.y = obj1.y + 150;
			obj2.z = obj1.z + 0;
		}
		else 
		{
			//do Noothing
		}
		
		//init();
		//animate();
		//updateArr(obj1,obj2,sptl);
		output(obj1,obj2,res,count);
}
			

</script> 
	</head>
<body>
	
	<input type="text" id="obj_spa_obj">
	<button onclick="arrayDistribution()">SEE SCENE</button>
	<input type="text" id="output">

	<script src ="three.min.js"></script>
	<script src="js/loaders/DDSLoader.js"></script>
	<script src="js/renderers/Projector.js"></script>
	<script src="js/renderers/CanvasRenderer.js"></script>
	<script src="js/Detector.js"></script>
	<script src="js/libs/stats.min.js"></script>		
	<div id="container"></div>
	<script>
	function output(obj1,obj2,res,count)
	{
			var SCREEN_WIDTH = window.innerWidth;
			var SCREEN_HEIGHT = window.innerHeight;
			var FLOOR = -250;

			var container, stats;

			var camera, scene;
			var canvasRenderer, webglRenderer;

			var mesh, zmesh, geometry;

			var mouseX = 0, mouseY = 0;

			var windowHalfX = window.innerWidth / 2;
			var windowHalfY = window.innerHeight / 2;

			var render_canvas = 1, render_gl = 1;
			var has_gl = 0;

			var bcanvas = document.getElementById( "rcanvas" );
			var bwebgl = document.getElementById( "rwebgl" );

			document.addEventListener( 'mousemove', onDocumentMouseMove, false );

			init();
			animate();

			render_canvas = !has_gl;
			bwebgl.style.display = has_gl ? "inline" : "none";
			bcanvas.className = render_canvas ? "button" : "button inactive";

			function init() {
				//console.log("HI",res);
				container = document.getElementById( 'container' );

				camera = new THREE.PerspectiveCamera( 75, SCREEN_WIDTH / SCREEN_HEIGHT, 1, 100000 );
				camera.position.z = 1500;

				scene = new THREE.Scene();

				// GROUND
				/*
				var x = document.createElement( "canvas" );
				var xc = x.getContext("2d");
				x.width = x.height = 128;
				xc.fillStyle = "#fff";
				xc.fillRect(0, 0, 128, 128);
				xc.fillStyle = "#000";
				xc.fillRect(0, 0, 64, 64);
				xc.fillStyle = "#999";
				xc.fillRect(32, 32, 32, 32);
				xc.fillStyle = "#000";
				xc.fillRect(64, 64, 64, 64);
				xc.fillStyle = "#555";
				xc.fillRect(96, 96, 32, 32);
				var texture = new THREE.CanvasTexture( x );
				texture.repeat.set( 10, 10 );
				texture.wrapS = THREE.RepeatWrapping;
				texture.wrapT = THREE.RepeatWrapping;
				var xm = new THREE.MeshBasicMaterial( { map: texture } );

				geometry = new THREE.PlaneBufferGeometry( 100, 100, 15, 10 );

				mesh = new THREE.Mesh( geometry, xm );
				mesh.position.set( 0, FLOOR, 0 );
				mesh.rotation.x = - Math.PI / 2;
				mesh.scale.set( 10, 10, 10 );
				scene.add( mesh );

				// SPHERES

				var material_spheres = new THREE.MeshLambertMaterial( { color: 0xdddddd } ),
					sphere = new THREE.SphereGeometry( 100, 16, 8 );

				for ( var i = 0; i < 10; i ++ ) {

					mesh = new THREE.Mesh( sphere, material_spheres );

					mesh.position.x = 500 * ( Math.random() - 0.5 );
					mesh.position.y = 300 * ( Math.random() - 0 ) + FLOOR;
					mesh.position.z = 100 * ( Math.random() - 1 );

					mesh.scale.x = mesh.scale.y = mesh.scale.z = 0.25 * ( Math.random() + 0.5 );

					scene.add( mesh );

				}

				*/

				// LIGHTS

				var ambient = new THREE.AmbientLight( 0x221100 );
				scene.add( ambient );

				var directionalLight = new THREE.DirectionalLight( 0xffeedd, 1.5 );
				directionalLight.position.set( 0, -70, 100 ).normalize();
				scene.add( directionalLight );

				// RENDERER

				if ( render_gl ) {

					try {

						webglRenderer = new THREE.WebGLRenderer();
						webglRenderer.setClearColor( 0x00ffff );
						webglRenderer.setPixelRatio( window.devicePixelRatio );
						webglRenderer.setSize( SCREEN_WIDTH, SCREEN_HEIGHT );
						webglRenderer.domElement.style.position = "relative";

						container.appendChild( webglRenderer.domElement );

						has_gl = 1;

					}
					catch (e) {
					}

				}

				if ( render_canvas ) {

					canvasRenderer = new THREE.CanvasRenderer();
					canvasRenderer.setClearColor( 0xffffff );
					canvasRenderer.setPixelRatio( window.devicePixelRatio );
					canvasRenderer.setSize( SCREEN_WIDTH, SCREEN_HEIGHT );
					container.appendChild( canvasRenderer.domElement );

				}

				// STATS
/*
				stats = new Stats();
				stats.domElement.style.position = 'absolute';
				stats.domElement.style.top = '0px';
				stats.domElement.style.zIndex = 100;
				container.appendChild( stats.domElement );
*/
				//

			//	bcanvas.addEventListener("click", toggleCanvas, false);
			//	bwebgl.addEventListener("click", toggleWebGL, false);
/*	
	if(count = 1)
			{
			for(i=0;i<res.length;i++)
			{
				THREE.Loader.Handlers.add( /\.dds$/i, new THREE.DDSLoader() );

				var loader = new THREE.JSONLoader();
				var callbackMale = function ( geometry, materials ) { createScene( geometry, materials, 100, 00, 1250 , 0 ) };
				var obj = res[i].concat(".js");
				console.log(obj);
				loader.load( obj, callbackMale );
				
				//

				window.addEventListener( 'resize', onWindowResize, false );

			}
*/
			
			var i=0;
				THREE.Loader.Handlers.add( /\.dds$/i, new THREE.DDSLoader() );

				var loader = new THREE.JSONLoader();
				var callbackMale = function ( geometry, materials ) { createScene( geometry, materials, obj1.x, obj1.y, 1250 , 0 ) };
				var callbackFemale = function ( geometry, materials ) { createScene( geometry, materials, obj2.x, obj2.y, 1250 , 0 ) };
				var xobj =  obj1.type.concat(".json");
				var yobj =  obj2.type.concat(".json");
				//console.log(obj);
				loader.load( xobj, callbackMale );
				loader.load( yobj, callbackFemale );

		
			
			
}
			function onWindowResize() {

				windowHalfX = window.innerWidth / 2;
				windowHalfY = window.innerHeight / 2;

				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();

				if ( webglRenderer ) webglRenderer.setSize( window.innerWidth, window.innerHeight );
				if ( canvasRenderer ) canvasRenderer.setSize( window.innerWidth, window.innerHeight );

			}

			function createScene( geometry, materials, x, y, z, b ) {

				zmesh = new THREE.Mesh( geometry, new THREE.MultiMaterial( materials ) );
				zmesh.position.set( x, y, z );
				//zmesh.scale.set( 2, 4, 4 );
				scene.add( zmesh );

			//	createMaterialsPalette( materials, 100, b );

			}

			function createMaterialsPalette( materials, size, bottom ) {

				for ( var i = 0; i < materials.length; i ++ ) {

					// material

					mesh = new THREE.Mesh( new THREE.PlaneBufferGeometry( size, size ), materials[i] );
					mesh.position.x = i * (size + 5) - ( ( materials.length - 1 )* ( size + 5 )/2);
					mesh.position.y = FLOOR + size/2 + bottom;
					mesh.position.z = -100;
					scene.add( mesh );

					// number
/*
					var x = document.createElement( "canvas" );
					var xc = x.getContext( "2d" );
					x.width = x.height = 128;
					xc.shadowColor = "#000";
					xc.shadowBlur = 7;
					xc.fillStyle = "orange";
					xc.font = "50pt arial bold";
					xc.fillText( i, 10, 64 );

					var xm = new THREE.MeshBasicMaterial( { map: new THREE.CanvasTexture( x ), transparent: true } );

					mesh = new THREE.Mesh( new THREE.PlaneBufferGeometry( size, size ), xm );
					mesh.position.x = i * ( size + 5 ) - ( ( materials.length - 1 )* ( size + 5 )/2);
					mesh.position.y = FLOOR + size/2 + bottom;
					mesh.position.z = -99;
					scene.add( mesh );*/

				}

			}

			function onDocumentMouseMove(event) {

				mouseX = ( event.clientX - windowHalfX );
				mouseY = ( event.clientY - windowHalfY );

			}

			//

			function animate() {

				requestAnimationFrame( animate );

				render();
			//	stats.update();

			}

			function render() {

				camera.position.x += ( mouseX - camera.position.x ) * .05;
				camera.position.y += ( - mouseY - camera.position.y ) * .05;

				camera.lookAt( scene.position );

				if ( render_gl && has_gl ) webglRenderer.render( scene, camera );
				if ( render_canvas ) canvasRenderer.render( scene, camera );

			}

			function toggleCanvas() {

				render_canvas = !render_canvas;
				bcanvas.className = render_canvas ? "button" : "button inactive";

				render_gl = !render_canvas;
				bwebgl.className = render_gl ? "button" : "button inactive";

				if( has_gl )
					webglRenderer.domElement.style.display = render_gl ? "block" : "none";

				canvasRenderer.domElement.style.display = render_canvas ? "block" : "none";

			}

			function toggleWebGL() {

				render_gl = !render_gl;
				bwebgl.className = render_gl ? "button" : "button inactive";

				render_canvas = !render_gl;
				bcanvas.className = render_canvas ? "button" : "button inactive";

				if( has_gl )
					webglRenderer.domElement.style.display = render_gl ? "block" : "none";

				canvasRenderer.domElement.style.display = render_canvas ? "block" : "none";

			}
}	
	</script>

	
	
	
</body>
</html>