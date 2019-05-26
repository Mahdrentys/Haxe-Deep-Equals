package tests;

import haxe.ds.StringMap;
import haxe.ds.Vector;
using deepequals.DeepEquals;

private enum TestEnum
{
    Value1;
    Value2;
    Value3(param:Int);
}

private class TestClass
{
    public var a = "";
    private var b:Int;

    public function new(_b:Int)
    {
        b = _b;
    }

    public function getB():Int
    {
        return b;
    }
}

class Test extends utest.Test
{
    public function specNull():Void
    {
        DeepEquals.deepEquals(null, null) == true;
        DeepEquals.deepEquals(null, 0) == false;
    }

    public function specInt():Void
    {
        1.deepEquals(1) == true;
        2.deepEquals(-1) == false;
    }

    public function specFloat():Void
    {
        1.5.deepEquals(1.5) == true;
        30.2.deepEquals(2.4) == false;
    }

    public function specBool():Void
    {
        true.deepEquals(true) == true;
        false.deepEquals(false) == true;
        true.deepEquals(false) == false;
        false.deepEquals(true) == false;
    }

    public function specString():Void
    {
        "".deepEquals("") == true;
        "aze".deepEquals("aze") == true;
        "aze".deepEquals("azer") == false;
    }

    public function specClass():Void
    {
        Array.deepEquals(Array) == true;
        String.deepEquals(String) == true;
        Array.deepEquals(String) == false;
    }

    public function specArray():Void
    {
        [].deepEquals([]) == true;
        [0, 1, 2].deepEquals([0, 1, 2]) == true;
        [0, 1].deepEquals([0, 1, 2]) == false;
        [0, 1, 3].deepEquals([0, 1, 2]) == false;
    }

    public function specVector():Void
    {
        Vector.fromArrayCopy([]).deepEquals(Vector.fromArrayCopy([])) == true;
        Vector.fromArrayCopy([0, 1, 2]).deepEquals(Vector.fromArrayCopy([0, 1, 2])) == true;
        Vector.fromArrayCopy([0, 1]).deepEquals(Vector.fromArrayCopy([0, 1, 2])) == false;
        Vector.fromArrayCopy([0, 1, 3]).deepEquals(Vector.fromArrayCopy([0, 1, 2])) == false;
    }
    
    public function specEnum():Void
    {
        TestEnum.deepEquals(TestEnum) == true;
        TestEnum.deepEquals(Type.ValueType) == false;
        
        Value1.deepEquals(Value1) == true;
        Value1.deepEquals(Value2) == false;
        Value3(1).deepEquals(Value3(1)) == true;
        Value3(1).deepEquals(Value3(2)) == false;
    }

    public function specFunction():Void
    {
        function(){}.deepEquals(function(){}) == true;
        function(){}.deepEquals(function(){}, false) == false;
    }

    public function specStruct():Void
    {
        ({}).deepEquals({}) == true;
        ({a: 1, b: "3"}).deepEquals({a: 1, b: "3"}) == true;
        ({a: 1, b: "4"}).deepEquals({a: 1, b: "3"}) == false;
        ({a: 1}).deepEquals({a: 1, b: "3"}) == false;
    }

    public function specMap():Void
    {
        var map1 = new Map<String, Int>();
        map1["a"] = 1;
        map1["b"] = 2;

        var map2 = new Map<String, Int>();
        map2["a"] = 1;
        map2["b"] = 2;

        var map3 = new StringMap<Int>();
        map3.set("a", 1);
        map3.set("b", 2);

        var map4 = new Map<String, Int>();
        map4["a"] = 1;

        var map5 = new Map<String, Int>();
        map5["a"] = 1;
        map5["b"] = 3;

        map1.deepEquals(map2) == true;
        map1.deepEquals(map3) == true;
        map1.deepEquals(map4) == false;
        map1.deepEquals(map5) == false;
    }

    public function specInstance():Void
    {
        var a = new TestClass(1);
        var b = new TestClass(1);
        var c = new TestClass(2);
        var d = new TestClass(1);
        d.a = "a";
        a.deepEquals(b) == true;
        a.deepEquals(c) == false;
        a.deepEquals(d) == false;

        DeepEquals.handle(TestClass, function(a:TestClass, b:TestClass):Bool
        {
            return false;
        });

        a.deepEquals(b) == false;

        DeepEquals.handle(TestClass, function(a:TestClass, b:TestClass):Bool
        {
            return b.getB() > a.getB();
        });

        a.deepEquals(c) == true;
        c.deepEquals(a) == false;
        DeepEquals.unHandle(TestClass);
    }

    public function specDate():Void
    {
        new Date(2019, 0, 1, 0, 0, 0).deepEquals(new Date(2019, 0, 1, 0, 0, 0)) == true;
        new Date(2019, 0, 1, 0, 0, 0).deepEquals(new Date(2019, 0, 1, 0, 0, 1)) == false;
    }
}