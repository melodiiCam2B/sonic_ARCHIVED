// import flx3d.Flx3DView;
// import flx3d.Flx3DUtil;
// import away3d.entities.Mesh;
// import openfl.display.BitmapData;
// import openfl.utils.Assets as OpenFlAssets;

// var test:Flx3DView;
// var mesh:Mesh;
// function onCreatePost(){
//     test = new Flx3DView(0,0,FlxG.width,FlxG.height);
//     test.screenCenter();
//     test.scrollFactor.set(0,0);
//     test.addModel('mods/base_mod/models/flixel.obj', function(model){
//         if(Std.string(model.asset.assetType) == 'mesh'){
//             model.asset.x = 0;
//             model.asset.y = 0;
//             model.asset.x = 0;
//             model.asset.rotationX = 90;
//             mesh = model.asset;
//             FlxTween.tween(model.asset, {rotationY: 360}, 5,{type: 2});
//         }
//     },Paths.cacheBitmap('models/FlixelColor.png'),false);
//     add(test);
// }

// function onDestroy(){
//    test.destroy();
// }