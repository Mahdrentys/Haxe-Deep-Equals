package tests;

import utest.UTest;

class Runner
{
    public static function main():Void
    {
        UTest.run([new Test()]);
    }
}