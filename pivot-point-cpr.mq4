//+------------------------------------------------------------------+
//|                                                  pivot-point.mq4 |
//|                                                           Meisam |
//|                                    contact.with.meisam@gmail.com |
//+------------------------------------------------------------------+
#property copyright "NEO"
#property link      "Neo.Reverser@gmail.com"
#property version   "1.0.0"
#property indicator_chart_window

#include <forall.mqh>

extern int COUNT = 200;
extern color COLOR = clrPlum;

double H, L, C, O, mid, res, sell_sl, buy_sl, mx, mn;
datetime T, FT, LT;
int TF=PERIOD_D1;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
   {
    for(int i = 0; i < COUNT; i++)
       {
        H = iHigh(NULL, TF, i);
        L = iLow(NULL, TF, i);
        C = iClose(NULL, TF, i);
        O = iOpen(NULL, TF, i);
        T = iTime(NULL, TF, i);
        res = ND((H + L + C) / 3);
        mid = ND((H + L) / 2);
        mx = MathMax(res, mid);
        mn = MathMin(res, mid);
        sell_sl = mx + MathAbs(res - mid);
        buy_sl = mn - +MathAbs(res - mid);
        FT = int(T) + (TF * 60);
        LT = int(T) + (TF * 60) * 2;
        if(TimeDayOfWeek(T) == 5)
           {
            FT = int(T) + (TF * 60) * 2;
            LT = int(T) + (TF * 60) * 4;
           }
        RectangleCreate(0, "rec " + (string)MathRand(), 0, FT, mid, LT, res, COLOR, 0, 2, true, true);
       }
    return(INIT_SUCCEEDED);
   }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
   {
//---
//--- return value of prev_calculated for next call
    return(rates_total);
   }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
   {
    DeleteAllObject();
   }
//+------------------------------------------------------------------+
