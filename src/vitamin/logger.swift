//-------------------------------------
//-------------------------------------
//--- author:陈南
//--- email:kevin-chen@foxmail.com
//--- wechat:kevin_nan
//--- date:2020.8.1
//--- Copyright (c) 2020-present, KevinChen2046 Technology.
//--- All rights reserved.
//-------------------------------------
//-------------------------------------

enum ConsoleColor:String {
    case BLACK = "30"
    case RED = "31"
    case GREEN = "32"
    case YELLOW = "33"
    case BLUE = "34"
    case PINK = "35"
    case CYAN = "36"
    case WHITE = "37"
}

class Logger{

    public static func line(_ args:Any...){
        var content:String="";
        for arg in args{
            content+="\(arg),"
        }
        content=content.subString(from:0,to:content.count-2);

        let total:Int = 20
        var contentLen:Int = total - (content.count / 2)>>0;
        var _line:String = ""
        while contentLen>0 {
            _line = _line+"-";
            contentLen-=1;
        }
        //let result:String = "\033[0;33;40m\t"+_line+content+_line+"\033[0m"
        let result:String = _line+content+_line
        print(result)
    }
    
    public static func log(_ args:Any...){
        Logger.__out(ConsoleColor.WHITE,"[LOG] ", args)
    }
    
    public static func info(_ args:Any...){
        Logger.__out(ConsoleColor.GREEN,"[INFO] ", args)
    }
    
    public static func warn(_ args:Any...){
        Logger.__out(ConsoleColor.YELLOW,"[WARN] ", args)
    }
    
    public static func debug(_ args:Any...){
        Logger.__out(ConsoleColor.CYAN,"[DEBUG] ", args)
    }
    
    public static func error(_ args:Any...){
        Logger.__out(ConsoleColor.RED,"[ERROR] ", args)
    }
    
    private static func __out(_ color:Any,_ tag:String,_ args:[Any]){
        var content:String = tag;
        for arg in args{
            content+="\(arg),"
        }
        content=content.subString(from:0,to:content.count-2);
        //content="\033[0;"+color+";40m"+content+"\033[0m"
        print(content)
    }
}
