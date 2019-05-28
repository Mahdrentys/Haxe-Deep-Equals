# Haxe Deep Equals

Haxe `deep-equals` library performs a recursive deep equality check by value on any type of variable. It can be used as a static extension.

## Usage

```haxe
import haxe.ds.Vector;
import deepequals.DeepEquals;
using deepequals.DeepEquals;

enum MyAwesomeEnum
{
    Value1;
    Value2;
    Value3(param:String);
}

class MyAwesomeClass
{

}

class Main
{
    public static function main():Void
    {
        // It works on basic types
        DeepEquals.deepEquals(1, 1); // returns true
        1.deepEquals(1); // returns true
        1.5.deepEquals(1.5); // returns true
        true.deepEquals(true); // returns true
        false.deepEquals(false); // returns true
        "abc".deepEquals("abc"); // returns true
        DeepEquals.deepEquals(null, null); // returns true

        // It works on arrays, vectors, maps and anonymous structures
        [0, 1, 2].deepEquals([0, 1, 2]); // returns true
        [0, 1, 2].deepEquals([0, 1, 3]); // returns false

        Vector.fromArrayCopy([0, 1, 2]).deepEquals(Vector.fromArrayCopy([0, 1, 2])); // returns true
        Vector.fromArrayCopy([0, 1]).deepEquals(Vector.fromArrayCopy([0, 1, 2])); // returns false

        ["a" => 1, "b" => 2].deepEquals(["a" => 1, "b" => 2]); // returns true
        ["a" => 1, "b" => 2].deepEquals(["a" => 1, "b" => 3]); // returns false

        ({a: 1, b: "3"}).deepEquals({a: 1, b: "3"}); // returns true
        ({a: 1, b: "4"}).deepEquals({a: 1, b: "3"}); // returns false

        // It works on types
        Array.deepEquals(Array); // returns true
        Array.deepEquals(String); // returns false
        MyAwesomeEnum.deepEquals(MyAwesomeEnum); // returns true

        // It works on enum values, and it performs a deep equality checks on their parameters
        Value1.deepEquals(Value1); // returns true
        Value1.deepEquals(Value2); // returns false
        Value3("abc").deepEquals(Value3("abc")); // returns true
        Value3("abc").deepEquals(Value3("abcd")); // returns false

        // It works also on whatever object by deeply checking its properties (both public and private).
        // But sometimes, for extern classes that don't have attributes for example, the check can't be performed.
        // So, you can define custom checking functions for a specific class:

        DeepEquals.handle(MyAwesomeClass, function(a:MyAwesomeClass, b:MyAwesomeClass):Bool
        {
            // You get the two instances to compare, and you can return true or false
            return true;
        });

        // PS: It's with this handle function that Strings, Arrays, Vectors, Maps and Dates are checked

        // In haxe, we can't check if two functions are equal.
        // So, by default, they are assumed as equal:
        (function():Bool { return true; }).deepEquals(function():Bool { return false; }); // returns true

        // If you to consider that the functions aren't equal, you can provide the last optional argument: public static function deepEquals(a:Dynamic, b:Dynamic, equalFunctions = true):Bool
        (function():Bool { return true; }).deepEquals(function():Bool { return true; }); // returns false
    }
}
```