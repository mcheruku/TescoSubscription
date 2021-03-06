IF OBJECT_ID(N'[dbo].[pxshGASHistoryDeliverySaver2]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE [dbo].[pxshGASHistoryDeliverySaver2]

		IF OBJECT_ID(N'[dbo].[pxshGASHistoryDeliverySaver2]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [dbo].[pxshGASHistoryDeliverySaver2] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [dbo].[pxshGASHistoryDeliverySaver2] not dropped.',16,1)
			END
	END
GO

/*
Author:  Peter, Hall    
Created: 2012/11    
Purpose: Get Delivery Saver subscription sign up history information for GAS  

--Modifications History--    
Changed On   Changed By  	Defect  Changes  Change Description     
19/07/2013   Deepmala, Trivedi	N/A     Extened to include 4 new additional plans
					3 Month Anytime Plan - Pay Monthly, 6 Month Anytime Plan - Pay Monthly,   
					3 Month Midweek Plan - Pay Monthly & 6 Month Midweek Plan - Pay Monthly
*/   

CREATE PROCEDURE [dbo].[pxshGASHistoryDeliverySaver2]      
(      
@branchlist  varchar(2000)= null      
)           
AS      
    
SELECT  CASE   
  WHEN SubscriptionPlanID = 1 THEN '3 Month Anytime Plan - Pay Upfront'    
  WHEN SubscriptionPlanID = 2 THEN '6 Month Anytime Plan - Pay Upfront'   
  WHEN SubscriptionPlanID = 5 THEN '3 Month Midweek Plan - Pay Upfront'   
  WHEN SubscriptionPlanID = 6 THEN '6 Month Midweek Plan - Pay Upfront' 
  WHEN SubscriptionPlanID = 7 THEN '3 Month Anytime Plan - Pay Monthly'
  WHEN SubscriptionPlanID = 8 THEN '6 Month Anytime Plan - Pay Monthly'   
  WHEN SubscriptionPlanID = 9 THEN '3 Month Midweek Plan - Pay Monthly'
  WHEN SubscriptionPlanID = 10 THEN '6 Month Midweek Plan - Pay Monthly'
  END as software,    
    convert(char(11),CustomerPlanStartDate, 112) as orderdate,    
      datepart(hh, CustomerPlanStartDate) as orderhour,count(*) as orders    
 FROM [tescosubscription].[CustomerSubscription] (nolock)    
Where [SubscriptionStatus] = 8    
and CustomerPlanStartDate between dateadd(dd, -15, getdate()) and getdate()    
and SwitchCustomerSubscriptionID IS NULL
group by    
  SubscriptionPlanID, convert(char(11),CustomerPlanStartDate, 112) ,datepart(hh, CustomerPlanStartDate)
  order by software DESC, orderdate, orderhour      
        
        
GO

GRANT EXECUTE ON [dbo].[pxshGASHistoryDeliverySaver2] TO [hs_central_supp]

IF OBJECT_ID(N'[dbo].[pxshGASHistoryDeliverySaver2]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [dbo].[pxshGASHistoryDeliverySaver2] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [dbo].[pxshGASHistoryDeliverySaver2] not created.',16,1)
	END
GO
