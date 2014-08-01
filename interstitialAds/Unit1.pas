unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls

  ,Androidapi.JNI.AdMob,
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Widget,
  Androidapi.JNI.Location,
  Androidapi.JNI.App,
  Androidapi.JNI.Util,
  Androidapi.helpers,
  FMX.helpers.android,
  FMX.Platform.Android,
  Androidapi.JNI.Embarcadero,
  Androidapi.JNI.GraphicsContentViewText, FMX.Layouts, FMX.Memo;


type
  TInterstitialAdListener = class(TJavaLocal, JAdListener)
  public
     FParent:TForm;
//    constructor Create(aParent:TForm);
    procedure onReceiveAd(ad: JAd); cdecl;
    procedure onFailedToReceiveAd(ad: JAd; error: JAdRequest_ErrorCode); cdecl;
    procedure onPresentScreen(ad: JAd); cdecl;
    procedure onDismissScreen(ad: JAd); cdecl;
    procedure onLeaveApplication(ad: JAd); cdecl;
  end;


type
   TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private




    { Private declarations }
  public
  listener2 :TInterstitialAdListener;
  listener:JAdListener;
  interstitialAd:JInterstitialAd;
  adRequest:JAdRequest;
    { Public declarations }
  end;



var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var i:integer;
begin
  FreeAndNil(listener2);
  listener2 := TInterstitialAdListener.Create;
  listener2.FParent := self;

  CallInUIThread(procedure
  begin
     interstitialAd := TJInterstitialAd.JavaClass.init(MainActivity,StringToJString('ca-app-pub-3249311258294379/1054515360'));
     adRequest := TJAdRequest.Create;
     adRequest.addTestDevice(TJAdRequest.JavaClass.TEST_EMULATOR);
     adRequest.addTestDevice(MainActivity.getDeviceID);
     interstitialAd.setAdListener(listener2);
     interstitialAd.loadAd(adRequest);
  end);

//   ShowMessage('ok.');

end;


 {$REGION 'Google Sample'}
// https://developers.google.com/mobile-ads-sdk/docs/admob/advanced?hl=tr

  //import com.google.ads.*;
//public class BannerExample extends Activity implements AdListener {
//private InterstitialAd interstitial;
//@Override  public void onCreate(Bundle savedInstanceState) {
//   super.onCreate(savedInstanceState);
//   setContentView(R.layout.main);
//   // Create the interstitial
//   interstitial = new InterstitialAd(this, MY_INTERSTITIAL_UNIT_ID);
//   // Create ad request
//   AdRequest adRequest = new AdRequest();
//   // Begin loading your interstitial
//   interstitial.loadAd(adRequest);
//   // Set Ad Listener to use the callbacks below
//   interstitial.setAdListener(this);  }
//
//   @Override  public void onReceiveAd(Ad ad) {
//   Log.d("OK", "Received ad");
//   if (ad == interstitial) {
//   interstitial.show();    }


 {$ENDREGION}


{ TInterstitialAdListener }

//procedure TInterstitialAdListener.onDismissScreen(ad: JAd);
//begin
//ShowMessage('onDismiss');
//end;
//
//procedure TInterstitialAdListener.onFailedToReceiveAd(ad: JAd;
//  error: JAdRequest_ErrorCode);
//begin
//ShowMessage('onFail');
//end;
//
//procedure TInterstitialAdListener.onLeaveApplication(ad: JAd);
//begin
//ShowMessage('nleave');
//end;
//
//procedure TInterstitialAdListener.onPresentScreen(ad: JAd);
//begin
//ShowMessage('onpresent');
//end;
//
//procedure TInterstitialAdListener.onReceiveAd(ad: JAd);
//begin
//
// form1.Button1.Text := JStringToString(   form1.interstitialAd.toString)
//
////   if form1.interstitialAd.isReady then
////      form1.Button1.Text :='onReceiveAd';  // this is work
//
//
//// if form1.interstitialAd.isReady then
////    form1.interstitialAd.show;  // --> black screen !!!
//
////ShowMessage('onRecevie');
////  CallInUIThreadAndWaitFinishing(procedure
////  begin
////        form1.interstitialAd.show; // --> black screen !!!
////  end);
//
//end;

{ TForm1.TInterstitiaPlAdListener }

//constructor TInterstitialAdListener.Create(aParent: TForm);
//begin
//FParent := aParent;
//end;

procedure TInterstitialAdListener.onDismissScreen(ad: JAd);
begin
  TForm1(FParent).Memo1.Lines.Add('onDismissScreen');
  TForm1(FParent).interstitialAd := nil;
  TForm1(FParent).adRequest := nil;

end;

procedure TInterstitialAdListener.onFailedToReceiveAd(ad: JAd;
  error: JAdRequest_ErrorCode);
begin
  TForm1(FParent).Memo1.Lines.Add('onFailedToReceiveAd');

end;

procedure TInterstitialAdListener.onLeaveApplication(ad: JAd);
begin
  TForm1(FParent).Memo1.Lines.Add('onLeaveApplication');

end;

procedure TInterstitialAdListener.onPresentScreen(ad: JAd);
begin
  TForm1(FParent).Memo1.Lines.Add('onPresentScreen');

end;

procedure TInterstitialAdListener.onReceiveAd(ad: JAd);
var
  I: Integer;
begin
  TForm1(FParent).Memo1.Lines.Add('onReceiveAd');

//   if FParent.interstitialAd.isReady then
//     form1.Button1.Text :='onReceiveAd';  // this is work

if Tform1(self.FParent).interstitialAd.isReady then
   Tform1(self.FParent).interstitialAd.show();

//
//for I := 1 to 10000 do
//begin
// TForm1(FParent).Memo1.Lines.Add(i.ToString());
// Application.ProcessMessages;
//
//end;

// CallInUIThreadAndWaitFinishing(procedure
// begin
//       Tform1(self.FParent).interstitialAd.show();
// end);
end;

end.
