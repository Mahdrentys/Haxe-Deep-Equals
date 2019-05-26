package deepequals;

import Type;
using haxe.EnumTools.EnumValueTools;
using Reflect;
using haxe.EnumTools.EnumValueTools;

class DeepEquals
{
    inline private static function isString(value:Dynamic):Bool
    {
        return Type.typeof(value).match(TClass(_)) && deepEquals(Type.typeof(value).getParameters()[0], String);
    }

    inline private static function isClass(value:Dynamic):Bool
    {
        return Type.typeof(value).match(TObject) && value.fields().indexOf("__name__") != -1;
    }

    inline private static function isArray(value:Dynamic):Bool
    {
        return Type.typeof(value).match(TClass(_)) && deepEquals(Type.typeof(value).getParameters()[0], Array);
    }

    inline private static function isEnum(value:Dynamic):Bool
    {
        return Type.typeof(value).match(TObject) && value.fields().indexOf("__ename__") != -1;
    }

    public static function deepEquals(a:Dynamic, b:Dynamic, equalFunctions = true):Bool
    {
        var aType = Type.typeof(a);
        var bType = Type.typeof(b);
        if (aType.getIndex() != bType.getIndex()) return false;
        var type = aType;

        if (type.match(TNull))
        {
            return true;
        }
        else if (type.match(TInt) || type.match(TFloat) || type.match(TBool) || (isString(a) && isString(b)))
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
        else if (isEnum(a) && isEnum(b))
        {
            return Type.getEnumName(a) == Type.getEnumName(b);
        }
        else if (type.match(TEnum(_)))
        {
            function getEnumName(value:ValueType):String
            {
                return Type.getEnumName(value.getParameters()[0]);
            }

            if (getEnumName(aType) != getEnumName(bType)) return false;
            if (EnumValueTools.getName(a) != EnumValueTools.getName(b)) return false;
            if (!deepEquals(EnumValueTools.getParameters(a), EnumValueTools.getParameters(b))) return false;
            return true;
        }
        else if (type.match(TFunction))
        {
            return equalFunctions;
        }

        return true;
    }
}