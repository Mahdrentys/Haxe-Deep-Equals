package tests;

using deepequal.DeepEqual;

class Test extends utest.Test
{
    public function specNull():Void
    {
        DeepEqual.deepEquals(null, null) == true;
        DeepEqual.deepEquals(null, 0) == false;
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
}