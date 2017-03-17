package;

import tink.testrunner.*;
import tink.testrunner.Assertion.*;
import tink.testrunner.Case;
import travix.Logger.*;

using tink.CoreApi;


class RunTests {
	static function main() {
		
		var code = 0;
		
		function oops(?pos:haxe.PosInfos) {
			trace(pos);
			code++;
		}
		
		var futures = [];
		
		// Test: cast from single case
		var single = new SingleCase();
		futures.push(
			function() return Runner.run(single).map(function(result) {
				code += result.errors().length;
				return Noise;
			})
		);
		
		// Test: cast from multiple cases
		futures.push(
			function() return Runner.run([single, single]).map(function(result) {
				code += result.errors().length;
				return Noise;
			})
		);
		
		var iter = futures.iterator();
		function next() {
			if(iter.hasNext()) iter.next()().handle(next);
			else {
				trace('Exiting with code: $code');
				exit(code);
			}
		}
		next();
	}
}

class SingleCase extends BasicCase {
	override function execute():Assertions {
		return isTrue(true);
	}
}