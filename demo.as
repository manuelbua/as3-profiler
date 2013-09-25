package
{
	import flash.display.Sprite;
	import profiler.*;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	[ SWF( backgroundColor = '#a0a0a0', width = '490', height = '200' ) ]
	public class demo extends Sprite
	{
		private var prof: Profiler = null;
		private var frameCount: int = 0;
		
		public function demo()
		{
			stage.frameRate = 16;
			
			ProfilerConfig.Width = stage.stageWidth;
			prof = new Profiler( 32 );
			addChild( prof );

			stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}

		public function onEnterFrame( evt: Event ): void
		{
			var i: int = 0;
			var it: int = 1000000;
			var fRes: Number = 0;
			var iRes: int = 0;
			
			frameCount++;

			prof.beginProfiling();

				i = it;
				prof.begin( "float", true );
					prof.begin( "fadd" );
					while( i-- ) { fRes += 1.; }
					prof.end( "fadd" );
				prof.end( "float" );

				i = it;
				prof.begin( "int", true );
					prof.begin( "iadd" );
					while( i-- ) { iRes += 1; }
					prof.end( "iadd" );
				prof.end( "int" );

				i = it;
				prof.begin( "float", true );
					prof.begin( "fsub" );
					while( i-- ) { fRes -= 1.; }
					prof.end( "fsub" );
				prof.end( "float" );

				i = it;
				prof.begin( "int", true );
					prof.begin( "isub" );
					while( i-- ) { iRes -= 1; }
					prof.end( "isub" );
				prof.end( "int" );

				i = it;
				prof.begin( "float", true );
					prof.begin( "fmul" );
					while( i-- ) { fRes *= 1.; }
					prof.end( "fmul" );
				prof.end( "float" );

				i = it;
				prof.begin( "int", true );
					prof.begin( "imul" );
					while( i-- ) { iRes *= 1; }
					prof.end( "imul" );
				prof.end( "int" );

				i = it;
				prof.begin( "float", true );
					prof.begin( "fdiv" );
					while( i-- ) { fRes /= 1.; }
					prof.end( "fdiv" );
				prof.end( "float" );

				i = it;
				prof.begin( "int", true );
					prof.begin( "idiv" );
					while( i-- ) { iRes /= 1; }
					prof.end( "idiv" );
				prof.end( "int" );

			prof.endProfiling();
		}
	}
}
