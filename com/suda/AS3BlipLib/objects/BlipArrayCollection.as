package com.suda.AS3BlipLib.objects
{
	import mx.collections.ArrayCollection;

	public class BlipArrayCollection extends ArrayCollection
	{
		public function BlipArrayCollection(source:Array=null)
		{
			super(source);
		}
		
		public function getBy(name:String, value:String):* {
			for each (var item:Object in this) {
				if (item.hasOwnProperty(name)) {
					if (value == item[name]) {
						return item;
					}
				} else {
					return null;
				}
			}
			
			return null;
		}
		
		public function getAllBy(name:String, value:String):BlipArrayCollection {
			var result:BlipArrayCollection = new BlipArrayCollection();
			
			for each (var item:Object in this) {
				if (item.hasOwnProperty(name)) {
					if (value == item[name]) {
						result.addItem(item);
					}
				} else {
					return null;
				}
			}
			
			return result;			
		}
		
		public function setAllBy(findName:String, findValue:String, setName:String, setValue:*):void {
			for each (var item:Object in this) {
				if (item.hasOwnProperty(findName) && item.hasOwnProperty(setName)) {
					if (findValue == item[findName]) {
						item[setName] = setValue;
					}
				} else {
					return;
				}
			}
		}
	}
}