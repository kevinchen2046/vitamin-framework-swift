//-------------------------------------
//-------------------------------------
//--- author:陈南
//--- email:kevin-chen@foxmail.com
//--- wechat:kevin_nan
//--- date:2020.7.24
//--- Copyright (c) 2020-present, KevinChen2046 Technology.
//--- All rights reserved.
//-------------------------------------
//-------------------------------------

typealias Handler = (String,[Any])->Void;

struct EventHandler { 
   var method:Handler?;
   var priority:Int;
   init(method: Handler?,priority:Int=0) {
        self.method=method;
        self.priority=priority;
    }
}

typealias HandlerList = [EventHandler];
class EventEmiter{
    var _map:[String:HandlerList]
    init(){
        self._map = [String:HandlerList]();
    }
    //-- 监听事件
    //-- type 事件类型
    //-- listener 事件回调
    //-- priority 事件优先级
    public func on(type:String,listener:Handler?,priority:Int=0)->EventHandler{
        // if (priority == 0){
        //      priority = 0;
        // }
        if (self._map[type] == nil){
            self._map[type]=HandlerList();
        }
        var list:HandlerList? = self._map[type];
        let index:Int = self.__getIndex(list:list,listener:listener);
        if(index == -1){
            let eventhandler=EventHandler(method:listener,priority:priority);
            list?.append(eventhandler);
            return eventhandler;
        }
        return list![index];
    }

    //-- 取消事件
    public func off(type:String,eventHandler:EventHandler)->EventEmiter{
        var list:HandlerList? = self._map[type];
        if (list == nil){return self;}
        if (list != nil && list?.count != 0){
            for (i,evthandler) in list!.enumerated() {
                if (evthandler == eventHandler) {
                    list?.remove(at:i);
                }
            }
        }
        return self
    }

    //-- 发送事件
    public func emit(type:String,params:Any...)->EventEmiter{
        var list = self._map[type]
        if(list == nil){
            return self
        }
        list.sorted{return $0["priority"]>$1["priority"]}
        for object in list{
            object.method(type,params);
        } 
        return self
    }

    private func __getIndex(list:HandlerList?,listener:Handler?)->Int{
        if(list==nil){return -1;}
        for (i,item) in list.enumerated(){
            if(item.method==listener){
                return i
            }
        }
        return -1
    }
}