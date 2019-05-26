package deepequals;

import haxe.EnumTools;
using Reflect;

class DeepEquals
{
    private static function isClass(value:Dynamic):Bool
    {
        return Type.typeof(value).match(TObject) && value.fields().indexOf("__name__") != -1;
    }

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
        else if (type.match(TInt) || type.match(TFloat) || type.match(TBool))
        {
            return a == b;
        }
        else if (isClass(a) && isClass(b))
        {
            return Type.getClassName(a) == Type.getClassName(b);
        }

        return true;
    }
}