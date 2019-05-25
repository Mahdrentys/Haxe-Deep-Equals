package deepequal;

import haxe.EnumTools;

class DeepEqual
{
    public static function deepEquals(a:Dynamic, b:Dynamic):Bool
    {
        var aType = Type.typeof(a);
        var bType = Type.typeof(b);
        if (aType.getIndex() != bType.getIndex()) return false;
        var type = aType;

        if (type.match(TNull))
        {
            return true;
        }
        else if (type.match(TInt))
        {
            return a == b;
        }

        return true;
    }
}