package
{
   import Shared.AS3.BSScrollingListEntry;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol64")]
   public class ExpeditionsPostMatchRewardEntry extends BSScrollingListEntry
   {
      
      public static const REWARD_TYPE_STANDARD:uint = 0;
      
      public static const REWARD_TYPE_XP:uint = 1;
      
      public static const REWARD_TYPE_SCORE:uint = 2;
      
      public static const REWARD_TYPE_XPD_STAMPS:uint = 3;
      
      public static const REWARD_TYPE_CAPS:uint = 4;
      
      public static const REWARD_TYPE_LEGENDARY:uint = 5;
       
      
      public var RewardIcon_mc:MovieClip;
      
      public var RewardValueText_mc:MovieClip;
      
      public var RewardValueSwitch_mc:MovieClip;
      
      public var RewardTitleText_mc:MovieClip;
      
      private var m_HasData:Boolean = false;
      
      private var m_IsSpecial:Boolean = false;
      
      public function ExpeditionsPostMatchRewardEntry()
      {
         super();
         addFrameScript(0,this.frame1,17,this.frame18,34,this.frame35);
         this.RewardValueSwitch_mc = this.RewardValueText_mc.RewardValueSwitch_mc;
         TextFieldEx.setTextAutoSize(this.RewardTitleText_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public static function translateTypeToSortOrder(param1:uint, param2:Boolean) : int
      {
         var _loc3_:int = 10;
         switch(param1)
         {
            case REWARD_TYPE_XP:
               _loc3_ = 0;
               break;
            case REWARD_TYPE_LEGENDARY:
               _loc3_ = 2;
               break;
            case REWARD_TYPE_CAPS:
            case REWARD_TYPE_SCORE:
            case REWARD_TYPE_XPD_STAMPS:
               _loc3_ = 3;
         }
         if(param2)
         {
            _loc3_ = 1;
         }
         return _loc3_;
      }
      
      override public function SetEntryText(param1:Object, param2:String) : *
      {
         var _loc3_:Boolean = false;
         if(param1)
         {
            this.RewardTitleText_mc.textField_tf.text = param1.rewardName;
            this.RewardTitleText_mc.textField_tf.text = this.RewardTitleText_mc.textField_tf.text.toUpperCase();
            _loc3_ = param1.type != REWARD_TYPE_STANDARD && param1.type != REWARD_TYPE_XP;
            this.RewardValueText_mc.gotoAndStop(_loc3_ ? "Icon" : "noIcon");
            TextFieldEx.setTextAutoSize(this.RewardValueSwitch_mc.rewardValue_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
            this.RewardValueSwitch_mc.rewardValue_tf.text = param1.count > 1 ? param1.count.toString() : "";
            switch(param1.type)
            {
               case REWARD_TYPE_SCORE:
                  this.RewardIcon_mc.gotoAndStop("SCORE");
                  break;
               case REWARD_TYPE_XPD_STAMPS:
                  this.RewardIcon_mc.gotoAndStop("ExpeditionCurrency");
                  break;
               case REWARD_TYPE_XP:
               case REWARD_TYPE_STANDARD:
               default:
                  this.RewardIcon_mc.gotoAndStop("off");
            }
            this.m_IsSpecial = param1.isSpecial;
            this.m_HasData = true;
         }
      }
      
      public function doAnimation() : void
      {
         if(this.m_HasData)
         {
            GlobalFunc.PlayMenuSound(this.m_IsSpecial ? "UIXpdObjectiveCompleteRewardEnhanced" : "UIXpdObjectiveCompleteReward");
            gotoAndPlay(this.m_IsSpecial ? "rollOnSpecial" : "rollOnStandard");
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame18() : *
      {
         stop();
      }
      
      internal function frame35() : *
      {
         stop();
      }
   }
}
