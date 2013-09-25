## An ActionScript profiler

When i was working on a proof-of-concept project i needed to know more about my code performances and googling for an AS3 profiler just pointed to ASProf, an AS2 profiler.

So i decided to write one, porting my other C++-based profiler belonging to another project: originally inspired by an article of [Steve Rabin](http://www.aiwisdom.com/) in the [Game Programming Gems #1](http://gameprogramminggems.com/) book.

It's always wise to remember that if you are serious about code profiling, you are better off to search for some professional tools: in the C++ arena my choice would have been Compuware's DevStudio, but [GlowCode](http://www.glowcode.com/) is an interesting alternative.

At the time i was writing ActionScript code, however, i didn't find any really usable tool for the job, so i thought to release it under a zlib/png license and some hints on how it works here.

### Usage

Once you included/imported/copied/referenced the package in your project, add the profiler's output (a Sprite) to your local render queue, and then set it up with some basic configuration:

	ProfilerConfig.Width = stage.stageWidth;
	ProfilerConfig.ShowMinMax = true;
	prof = new Profiler( 32 );
	addChild( prof );

Now let's fake some work and feed the profiler with some data:

	var i: int = 0;
	var it: int = 1000000;

	prof.beginProfiling();

	i = it;
	prof.begin( "fadd" );
	while( i-- ) { fRes += 1.; }
	prof.end( "fadd" );

	i = it;
	prof.begin( "iadd" );
	while( i-- ) { iRes += 1; }
	prof.end( "iadd" );

	i = it;
	prof.begin( "fsub" );
	while( i-- ) { fRes -= 1.; }
	prof.end( "fsub" );

	i = it;
	prof.begin( "isub" );
	while( i-- ) { iRes -= 1; }
	prof.end( "isub" );

	prof.endProfiling();

The profiler should show some signs of life, like the following screenshots:

![profiler_in_action](http://i.imgur.com/fEP51aj.png "The profiler in action")

And this is it!
Another useful thing the profiler can do is *grouping*, so that you can group different code fragments belonging to your most logical schema, by wrapping the same ProfileNode around the various different code fragments: here i'm grouping math operations by their type, just to keep things organized a bit:

	var i: int = 0;
	var it: int = 1000000;

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

	prof.endProfiling();

Now the graph should look somewhat better:

![profiler_grouped_calls](http://i.imgur.com/YaReT3y.png "Grouped calls")

That's all there is to it, hope it will be useful!