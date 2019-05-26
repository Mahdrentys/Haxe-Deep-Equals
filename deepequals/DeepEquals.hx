package deepequals;

import haxe.EnumTools;
using Reflect;
using haxe.EnumTools.EnumValueTools;

class DeepEquals
{
    inline private static function isClass(value:Dynamic):Bool
    {
        return Type.typeof(value).match(TObject) && value.fields().indexOf("__name__") != -1;
    }

    inline private static function isArray(value:Dynamic):Bool
    {
        return Type.typeof(value).match(TClass(_)) && deepEquals(Type.typeof(value).getParameters()[0], Array);
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
        else if (isArray(a) && isArray(b))
        {
            if (a.length != b.length) return false;

            for (i in 0...a.length)
            {
                if (!deepEquals(a[i], b[i])) return false;
            }

            return true;
        }

        return true;
    }
}