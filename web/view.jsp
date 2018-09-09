<%-- 
    Document   : view
    Created on : 15 Mar, 2016, 2:08:17 AM
    Author     : mansi
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javapackage.ObjectNode" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Scene Generated</h1>
        <br/><br/>
        <%  String obname,type,occ;
            int pos,x,y,z,flag;
            %>
            <script>
                var left=[];
                var spatial=[];
            </script>
            <%
            ArrayList<ObjectNode>leftob=(ArrayList<ObjectNode>) request.getAttribute("leftobjs");
            for(int i=0;i<leftob.size();i++)
            {
            obname=leftob.get(i).Name;
            type=leftob.get(i).Type;
            occ=leftob.get(i).Number;
            pos=leftob.get(i).pos;
            x=leftob.get(i).x;
            y=leftob.get(i).y;
            z=leftob.get(i).z;
            flag=leftob.get(i).flag;
            %>
            <script type ="text/javascript">
            var val1="<%=obname%>";
            var val2="<%=type%>";
            var val3="<%=occ%>";
            var val4=<%=pos%>;
            var val5=<%=x%>;
            var val6=<%=y%>;
            var val7=<%=z%>;
            var val8=<%=flag%>;
            console.log(val1);
            console.log(val2);
            var obvar={name:val1,type:val2,occ:val3,pos:val4,x:val5,y:val6,z:val7,flag:val8};
            left.push(obvar);
            </script>
            <%}%>
            <script>
                var len=left.length;
                console.log(len);
                for(var i=0;i<left.length;i++)
                    console.log(left[i]);
            </script>
            <%
            ArrayList<ObjectNode>spatialob=(ArrayList<ObjectNode>) request.getAttribute("spatialobjs");
            for(int i=0;i<spatialob.size();i++)
            {
            obname=spatialob.get(i).Name;
            type=spatialob.get(i).Type;
            occ=spatialob.get(i).Number;
            pos=spatialob.get(i).pos;
            x=spatialob.get(i).x;
            y=spatialob.get(i).y;
            z=spatialob.get(i).z;
            flag=spatialob.get(i).flag;
            %>
            <script type ="text/javascript">
            var val1="<%=obname%>";
            var val2="<%=type%>";
            var val3="<%=occ%>";
            var val4=<%=pos%>;
            var val5=<%=x%>;
            var val6=<%=y%>;
            var val7=<%=z%>;
            var val8=<%=flag%>;
            console.log(val1);
            console.log(val2);
            var obvar={name:val1,type:val2,occ:val3,pos:val4,x:val5,y:val6,z:val7,flag:val8};
            spatial.push(obvar);
            </script>
            <%}%>

            <script>
                 var newArr = [];
		 var flag;
		 for(var i=0;i<spatial.length;i++)
		 {
                     //console.log("sptl",spatial[i]);
                     if(spatial[i].pos !== 0)
                     {
                         if(newArr.length < 2)
                         {
                             newArr.push(spatial[i]);
                         }
                         
                         else
                         {
                             flag=0;
                            for(var j=0;j<newArr.length;j++)
                            {
                                   if(newArr[j].pos === spatial[i].pos)
                                   {
                                        flag = flag+1;
                                   }
                                   
                            }
                            if(flag === 0)
                            {
                                 newArr.push(spatial[i]);
                            }
                         }

                     }
                 }
                 var j;
                 z=10;
                 for(j=0;j<left.length;j++)
                 {
                     left[j].x=-110;
                     left[j].y=0;
                     left[j].z=z;
                     z = z+50;
                 }
                 console.log(newArr);
                  console.log(left);
            //newArray formed
            				
            </script>
              
            <script>
            // To create obj sptl obj relation and update newArr acording to it.
            for(var i=0;i<spatial.length;i+=3)
			{
				var obj1= spatial[i];
				var sptl=spatial[i+1];
				var obj2=spatial[i+2];
		//		console.log("Hii",obj1,sptl,obj2);
				search(obj1,obj2,sptl);
			}
                        
             function search(obj1,obj2,sptl)
             {
                 var IndexOfObj1,IndexOfObj2;
                 var i=0,j=0;
                 while(obj1.pos !== newArr[i].pos)
                 {
                       i++;
                 }
                 IndexOfObj1 = i;
                 obj1 = newArr[i];
                 
                 while(obj2.pos !== newArr[j].pos)
                 {
                       j++;
                 }
                 IndexOfObj2 = j;       // to store index of obj2 from newArr
                 obj2 = newArr[j];      // update obj2 from newArr
                 genericSpatial(obj1,obj2,sptl,IndexOfObj1,IndexOfObj2);
            }
            function genericSpatial(obj1,obj2,sptl,IndexOfObj1,IndexOfObj2)
            {
                console.log("Mansi",obj1,obj2);
                                        if(sptl.name === "inside")
					{
						obj1.x = obj2.x + 0;
						obj1.y = obj2.y + 0;
						obj1.z = obj2.z + 0;
					
					
					}
					else if(sptl.name === "outside")
					{
						obj1.x = obj2.x + 150;
						obj1.y = obj2.y + 0;
						obj1.z = obj2.z + 0;
					}
					else if(sptl.name === "on")
					{
                                                                console.log("LIMO");
						obj1.x = obj2.x + 0;
						obj1.y = obj2.y + 150;
						obj1.z = obj2.z + 0;
					}
					else if(sptl.name === "top")
					{
						obj1.x = obj2.x + 0;
						obj1.y = obj2.y + 150;
						obj1.z = obj2.z + 0;
					}
					else if(sptl.name=== "at")
					{
						obj1.x = obj2.x + 0;
						obj1.y = obj2.y + 150;
						obj1.z = obj2.z + 0;
					}
					else if(sptl.name === "beside")
					{
						obj1.x = obj2.x + 50;
						obj1.y = obj2.y + 0;
						obj1.z = obj2.z + 0;
					}
					
					else if(sptl.name === "under")
					{
						obj1.x = obj2.x + 0;
						obj1.y = obj2.y - 150;
						obj1.z = obj2.z + 0;
					}	
					else if(sptl.name === "left")
					{
						obj1.x = obj2.x - 150;
						obj1.y = obj2.y + 0;
						obj1.z = obj2.z + 0;
					}
					else if(sptl.name === "right")
					{
						obj1.x = obj2.x + 150;
						obj1.y = obj2.y + 0;
						obj1.z = obj2.z + 0;
					}
					else if(sptl.name === "back")
					{
						obj1.x = obj2.x + 0;
						obj1.y = obj2.y + 0;
						obj1.z = obj2.z - 150;
					}
					else if(sptl.name === "above")
					{
						obj1.x = obj2.x + 0;
						obj1.y = obj2.y + 150;
						obj1.z = obj2.z + 0;
					}
					
					else if(sptl.name === "along")
					{
						obj1.x = obj2.x + 0;
						obj1.y = obj2.y + 150;
						obj1.z = obj2.z + 0;
					}
                                        else if(sptl.name === "next")
					{
						obj1.x = obj2.x + 150;
						obj1.y = obj2.y + 0;
						obj1.z = obj2.z + 0;
					}
                                        else if(sptl.name === "front")
					{
                                                            console.log("LIMO");
						obj1.x = obj2.x + 0;
						obj1.y = obj2.y + 0;
						obj1.z = obj2.z + 150;
                                                                console.log("Man :: ",obj1,obj2);
					}
					else 
					{
						//do Noothing
					}
					
					newArr[IndexOfObj1] = obj1;
					newArr[IndexOfObj2] = obj2;
					console.log("index1",IndexOfObj1);
                                        console.log("index2",IndexOfObj2);
					//init();
					//animate();
					//updateArr(obj1,obj2,sptl);
					//	output(obj1,obj2);
		                  
                
            }
            
            console.log("newArr",newArr);

            </script>
      
                       <script src ="three.min.js"></script>
            <script src="js/loaders/DDSLoader.js"></script>
            <script src="js/renderers/Projector.js"></script>
            <script src="js/renderers/CanvasRenderer.js"></script>
            <script src="js/Detector.js"></script>
            <script src="js/libs/stats.min.js"></script>		
			
	<div id="container"></div>
	<script>
//                        var x = [];
//			var y = [];
//			var z = [];
            
//                        var positions = {};
                        var indexes = [];
                        var current_index = 0;

            
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
				camera.position.z = 1600;

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
             
                            
                            for(var i=0;i<newArr.length;i++)
                            {
//                                
//					 x.push(-100+newArr[i].x);
//					 y.push(10+newArr[i].y);
//					 z.push(1250+newArr[i].z);
//                                         
                                         //indexes.push(i);
                                       
                               !function outer(index)
                               {
                                    THREE.Loader.Handlers.add( /\.dds$/i, new THREE.DDSLoader() );
                                    var loader = new THREE.JSONLoader();
                                    var callbackMale = function ( geometry, materials ) { createScene( geometry, materials,index,0,newArr[index].occ) };
                                    var obj = newArr[index].name.concat(".json");


                                    console.log("hii ");
                                    loader.load( obj, callbackMale );
                                }(i);
				//

				//window.addEventListener( 'resize', onWindowResize, false );
                            }

                            for(var i=0;i<left.length;i++)
                            {
//                                
//					 x.push(-100+newArr[i].x);
//					 y.push(10+newArr[i].y);
//					 z.push(1250+newArr[i].z);
//                                         
                                         //indexes.push(i);
                                       
                               !function outer(index1)
                               {
                                    THREE.Loader.Handlers.add( /\.dds$/i, new THREE.DDSLoader() );
                                    var loader = new THREE.JSONLoader();
                                    var callbackMale = function ( geometry, materials ) { createScene( geometry, materials,index1,1,left[index1].occ); };
                                    var obj = left[index1].name.concat(".json");


                                    console.log("hii ");
                                    loader.load( obj, callbackMale );
                                }(i);
				//

				//window.addEventListener( 'resize', onWindowResize, false );
                            }
    }
			

			function onWindowResize() {

				windowHalfX = window.innerWidth / 2;
				windowHalfY = window.innerHeight / 2;

				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();

				if ( webglRenderer ) webglRenderer.setSize( window.innerWidth, window.innerHeight );
				if ( canvasRenderer ) canvasRenderer.setSize( window.innerWidth, window.innerHeight );

			}

			function createScene( geometry, materials,index,countF,occu ) {
                                var jj=0,newZ=0;
                                while(jj!=occu)
                                {
                                console.log(current_index);
                                
                                //var index = indexes[current_index++] ;
                                if(countF === 0)
				{
                                        var yy = 10 + newArr[index].y ;
            				var zz = 1250+ newArr[index].z + newZ;
                                        var xx = -100 + newArr[index].x ;
                                }
                                if(countF === 1)
				{
                                var xx = -100 + left[index].x ;
                                var yy = 10 + left[index].y ;
				var zz = 1250+ left[index].z + newZ;
                                }          
                                newZ=newZ+40;
                                jj = jj + 1; 
                                //console.log(newArr[index].x,newArr[index].y,newArr[index].z);
					indexes.pop();
					
                                zmesh = new THREE.Mesh( geometry, new THREE.MultiMaterial( materials ) );
				zmesh.position.set( xx, yy, zz );
				//zmesh.scale.set( 2, 4, 4 );
				scene.add( zmesh );
                            }
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
	
	</script>

    </body>
</html>
