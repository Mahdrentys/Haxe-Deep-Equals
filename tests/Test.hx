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
}