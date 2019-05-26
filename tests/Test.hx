package tests;

using deepequals.DeepEquals;

private enum TestEnum
{
    Value1;
    Value2;
    Value3(param:Int);
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
}