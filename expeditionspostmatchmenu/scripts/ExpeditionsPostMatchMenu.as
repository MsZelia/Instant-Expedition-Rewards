package
{
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.IMenu;
   import Shared.GlobalFunc;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol80")]
   public class ExpeditionsPostMatchMenu extends IMenu
   {
      
      public static const EVENT_EXIT:String = "Expeditions::Exit";
      
      private static const INIT_ANIM_WAIT_MS:uint = 5;
      
      private static const OBJECTIVE_ANIM_WAIT_MS:uint = 7;
      
      private static const REWARD_ANIM_WAIT_MS:uint = 3;
      
      private static const PRIMARY_OBJECTIVE_ANIM_WAIT_MS:uint = 4;
      
      public var Internal_mc:MovieClip;
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var ExScreenshotContainer_mc:ImageFixture;
      
      public var MainHeader_mc:MovieClip;
      
      public var ExpeditionName_mc:MovieClip;
      
      public var ObjectiveCompleteHeader_mc:MovieClip;
      
      public var RewardsListHeader_mc:MovieClip;
      
      public var PrimaryCheckbox_mc:MovieClip;
      
      public var ObjectivesContainer_mc:MovieClip;
      
      public var RewardsContainer_mc:MovieClip;
      
      private var ExitBtn:BSButtonHintData;
      
      private var m_ObjectiveClipsV:Vector.<ExpeditionsPostMatchObjectiveEntry>;
      
      private var m_RewardClipsV:Vector.<ExpeditionsPostMatchRewardEntry>;
      
      private var m_AnimTimer:Timer;
      
      public function ExpeditionsPostMatchMenu()
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:DisplayObject = null;
         this.ExitBtn = new BSButtonHintData("$EXIT","ESC","PSN_Select","Xenon_Start",1,this.onExit);
         this.m_ObjectiveClipsV = new Vector.<ExpeditionsPostMatchObjectiveEntry>();
         this.m_RewardClipsV = new Vector.<ExpeditionsPostMatchRewardEntry>();
         addFrameScript(0,this.frame1,15,this.frame16,29,this.frame30);
         super();
         this.ButtonHintBar_mc = this.Internal_mc.ButtonHintBar_mc;
         this.ExScreenshotContainer_mc = this.Internal_mc.ExScreenshotContainer_mc;
         this.MainHeader_mc = this.Internal_mc.MainHeader_mc;
         this.ExpeditionName_mc = this.Internal_mc.ExpeditionName_mc;
         this.ObjectiveCompleteHeader_mc = this.Internal_mc.ObjectiveCompleteHeader_mc;
         this.RewardsListHeader_mc = this.Internal_mc.RewardsListHeader_mc;
         this.PrimaryCheckbox_mc = this.Internal_mc.PrimaryCheckbox_mc;
         this.ObjectivesContainer_mc = this.Internal_mc.ObjectivesContainer_mc;
         this.RewardsContainer_mc = this.Internal_mc.RewardsContainer_mc;
         var _loc1_:* = 0;
         while(_loc1_ < this.ObjectivesContainer_mc.numChildren)
         {
            _loc2_ = this.ObjectivesContainer_mc.getChildAt(_loc1_);
            if(_loc2_)
            {
               _loc2_.visible = false;
               this.m_ObjectiveClipsV.push(_loc2_ as ExpeditionsPostMatchObjectiveEntry);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.RewardsContainer_mc.numChildren)
         {
            _loc3_ = this.RewardsContainer_mc.getChildAt(_loc1_);
            if(_loc3_)
            {
               this.m_RewardClipsV.push(_loc3_ as ExpeditionsPostMatchRewardEntry);
            }
            _loc1_++;
         }
         this.ExScreenshotContainer_mc.clipWidth = this.ExScreenshotContainer_mc.width;
         this.ExScreenshotContainer_mc.clipHeight = this.ExScreenshotContainer_mc.height;
         this.ExScreenshotContainer_mc.mouseEnabled = false;
         this.ExScreenshotContainer_mc.mouseChildren = false;
         this.ButtonHintBar_mc.SetButtonHintData(new <BSButtonHintData>[this.ExitBtn]);
      }
      
      override public function onAddedToStage() : void
      {
         super.onAddedToStage();
         BSUIDataManager.Subscribe("ExpeditionsPostMatchData",this.onExpeditionsPostMatchData);
         TextFieldEx.setTextAutoSize(this.MainHeader_mc.MainHeader_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.ExpeditionName_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.ObjectiveCompleteHeader_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.RewardsListHeader_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         if(currentLabel == "off")
         {
            gotoAndPlay("rollOn");
            this.m_AnimTimer = new Timer(INIT_ANIM_WAIT_MS,1);
            this.m_AnimTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onInitAnimTimerComplete);
            this.m_AnimTimer.start();
         }
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {
         var _loc3_:Boolean = false;
         if(!_loc3_ && !param2)
         {
            switch(param1)
            {
               case "TogglePOV":
               case "Map":
               case "Start":
               case "ForceClose":
                  _loc3_ = true;
                  this.onExit();
            }
         }
         return _loc3_;
      }
      
      private function initRewards(param1:Array) : void
      {
         var _loc2_:Array = param1.concat().sort(this.rewardsSort);
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc3_ < this.m_RewardClipsV.length)
            {
               this.m_RewardClipsV[_loc3_].SetEntryText(_loc2_[_loc3_],"");
            }
            _loc3_++;
         }
      }
      
      private function initObjectives(param1:Array) : void
      {
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            if(_loc2_ < this.m_ObjectiveClipsV.length)
            {
               this.m_ObjectiveClipsV[_loc2_].SetEntryText(param1[_loc2_],"");
               this.m_ObjectiveClipsV[_loc2_].visible = true;
            }
            _loc2_++;
         }
         if(param1.length < this.m_ObjectiveClipsV.length)
         {
            _loc2_ = param1.length;
            while(_loc2_ < this.m_ObjectiveClipsV.length)
            {
               this.m_ObjectiveClipsV[_loc2_].visible = false;
               _loc2_++;
            }
         }
      }
      
      private function onExit() : void
      {
         GlobalFunc.PlayMenuSound("UIMenuCancel");
         BSUIDataManager.dispatchEvent(new Event(EVENT_EXIT));
      }
      
      private function getNumOfCompleteOptionalObjectives() : int
      {
         var _loc2_:ExpeditionsPostMatchObjectiveEntry = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.m_ObjectiveClipsV)
         {
            if(_loc2_.isComplete)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      private function rewardsSort(param1:Object, param2:Object) : int
      {
         var _loc3_:int = ExpeditionsPostMatchRewardEntry.translateTypeToSortOrder(param1.type,param1.isSpecial);
         var _loc4_:int = ExpeditionsPostMatchRewardEntry.translateTypeToSortOrder(param2.type,param2.isSpecial);
         if(_loc3_ != _loc4_)
         {
            if(_loc3_ < _loc4_)
            {
               return -1;
            }
            return 1;
         }
         return 0;
      }
      
      private function onExpeditionsPostMatchData(param1:FromClientDataEvent) : void
      {
         if(Boolean(param1) && Boolean(param1.data))
         {
            this.ExpeditionName_mc.textField_tf.text = param1.data.expeditionName;
            this.ExpeditionName_mc.textField_tf.text = this.ExpeditionName_mc.textField_tf.text.toUpperCase();
            this.initObjectives(param1.data.objectives);
            this.initRewards(param1.data.rewards);
            this.ExScreenshotContainer_mc.LoadImageFixtureFromUIData(param1.data.image,GlobalFunc.STORE_IMAGE_TEXTURE_BUFFER);
         }
      }
      
      private function onInitAnimTimerComplete(param1:TimerEvent) : void
      {
         this.m_AnimTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onInitAnimTimerComplete);
         this.PrimaryCheckbox_mc.gotoAndStop("pass");
         this.PrimaryCheckbox_mc.Icon_mc.gotoAndPlay("rollOnPrimary");
         GlobalFunc.PlayMenuSound("UIXpdObjectiveCompleteRewardFanfare");
         this.m_AnimTimer.reset();
         this.m_AnimTimer.delay = PRIMARY_OBJECTIVE_ANIM_WAIT_MS;
         this.m_AnimTimer.repeatCount = 1;
         this.m_AnimTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onPrimaryObjectiveAnimTimerComplete);
         this.m_AnimTimer.start();
      }
      
      private function onPrimaryObjectiveAnimTimerComplete(param1:TimerEvent) : void
      {
         this.m_AnimTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onPrimaryObjectiveAnimTimerComplete);
         this.m_AnimTimer.reset();
         var _loc2_:int = this.getNumOfCompleteOptionalObjectives();
         if(_loc2_ > 0)
         {
            this.m_AnimTimer.delay = OBJECTIVE_ANIM_WAIT_MS;
            this.m_AnimTimer.repeatCount = _loc2_;
            this.m_AnimTimer.addEventListener(TimerEvent.TIMER,this.onObjectiveAnimTimer);
            this.m_AnimTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onObjectiveAnimTimerComplete);
            this.m_AnimTimer.start();
         }
         else
         {
            this.onObjectiveAnimTimerComplete(null);
         }
      }
      
      private function onObjectiveAnimTimer(param1:TimerEvent) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.m_ObjectiveClipsV.length)
         {
            if(this.m_ObjectiveClipsV[_loc2_].isComplete && !this.m_ObjectiveClipsV[_loc2_].hasAnimPlayed)
            {
               this.m_ObjectiveClipsV[_loc2_].doAnimation();
               break;
            }
            _loc2_++;
         }
      }
      
      private function onObjectiveAnimTimerComplete(param1:TimerEvent) : void
      {
         this.m_AnimTimer.removeEventListener(TimerEvent.TIMER,this.onObjectiveAnimTimer);
         this.m_AnimTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onObjectiveAnimTimerComplete);
         this.m_AnimTimer.reset();
         this.m_AnimTimer.delay = OBJECTIVE_ANIM_WAIT_MS - REWARD_ANIM_WAIT_MS;
         this.m_AnimTimer.repeatCount = 1;
         this.m_AnimTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onBeforeRewardsTimer);
         this.m_AnimTimer.start();
      }
      
      private function onBeforeRewardsTimer(param1:TimerEvent) : void
      {
         this.m_AnimTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onBeforeRewardsTimer);
         this.m_AnimTimer.reset();
         this.m_AnimTimer.delay = REWARD_ANIM_WAIT_MS;
         this.m_AnimTimer.repeatCount = this.m_RewardClipsV.length;
         this.m_AnimTimer.addEventListener(TimerEvent.TIMER,this.onRewardAnimTimer);
         this.m_AnimTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onRewardAnimTimerComplete);
         this.m_AnimTimer.start();
      }
      
      private function onRewardAnimTimer(param1:TimerEvent) : void
      {
         var _loc2_:uint = uint(this.m_AnimTimer.currentCount - 1);
         if(_loc2_ < this.m_RewardClipsV.length)
         {
            this.m_RewardClipsV[_loc2_].doAnimation();
         }
      }
      
      private function onRewardAnimTimerComplete(param1:TimerEvent) : void
      {
         this.m_AnimTimer.reset();
         this.m_AnimTimer.removeEventListener(TimerEvent.TIMER,this.onRewardAnimTimer);
         this.m_AnimTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onRewardAnimTimerComplete);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame16() : *
      {
         stop();
      }
      
      internal function frame30() : *
      {
         stop();
      }
   }
}

