package tests;

using deepequal.DeepEqual;

class Test extends utest.Test
{
    public function specNull():Void
    {
        DeepEqual.deepEquals(null, null) == true;
        DeepEqual.deepEquals(null, 0) == false;
    }
}