package
{
   import Shared.AS3.BSScrollingListEntry;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol32")]
   public class ExpeditionsPostMatchObjectiveEntry extends BSScrollingListEntry
   {
       
      
      public var ObjectiveName_mc:MovieClip;
      
      public var CheckBox_mc:MovieClip;
      
      private var m_isComplete:Boolean = false;
      
      private var m_hasAnimPlayed:Boolean = false;
      
      public function ExpeditionsPostMatchObjectiveEntry()
      {
         super();
         TextFieldEx.setTextAutoSize(this.ObjectiveName_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public function get isComplete() : Boolean
      {
         return this.m_isComplete;
      }
      
      public function get hasAnimPlayed() : Boolean
      {
         return this.m_hasAnimPlayed;
      }
      
      override public function SetEntryText(param1:Object, param2:String) : *
      {
         if(param1)
         {
            this.m_isComplete = param1.isComplete;
            this.ObjectiveName_mc.textField_tf.text = param1.objective;
            this.ObjectiveName_mc.textField_tf.text = this.ObjectiveName_mc.textField_tf.text.toUpperCase();
            this.CheckBox_mc.gotoAndStop(!!param1.isComplete ? "pass" : "fail");
         }
      }
      
      public function doAnimation() : void
      {
         if(this.visible && this.m_isComplete)
         {
            GlobalFunc.PlayMenuSound("UIXpdObjectiveCompleteCheckbox");
            this.CheckBox_mc.Icon_mc.gotoAndPlay("rollOn");
            this.m_hasAnimPlayed = true;
         }
      }
   }
}
