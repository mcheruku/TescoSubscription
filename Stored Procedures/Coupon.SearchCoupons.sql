USE [TescoSubscription]
GO

IF OBJECT_ID(N'[Coupon].[SearchCoupons]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[SearchCoupons]

		IF OBJECT_ID(N'[Coupon].[SearchCoupons]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[SearchCoupons] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[SearchCoupons] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [Coupon].[SearchCoupons] 
(
@CampaignID BIGINT = NULL
,@PageCount INT
,@PageSize INT
)
AS
/*  
    Author:			Robin
	Date created:	25 Apr 2014
	Purpose:		To get Campaign Details Based on CampaignID
	Behaviour:		
	Usage:			Often/Hourly
	Called by:		Juvo
	WarmUP Script:	Execute [Coupon].[SearchCoupons]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	
*/
 

BEGIN
DECLARE
       @Size      INT

IF @PageSize = -1 

BEGIN
     SET @Size = (Select Count(1) From Coupon.Coupon) 
	 SET @PageCount=1 
END
			
ELSE 
     SET @Size = @PageSize 



	 SELECT TOP (@Size) *  FROM(			
			SELECT ROW_NUMBER() OVER (ORDER BY TempT.[CouponID] DESC
											)
							AS RowNumber
			, TempT.*
	   FROM(SELECT CC.CouponID,
	 CC.CouponCode,
	 CA.DescriptionLong,
	 CCM.CustomerID
	 From Coupon.Coupon CC WITH (NOLOCK) INNER JOIN Coupon.Campaign CA WITH (NOLOCK)
	 ON CC.CampaignID=CA.CampaignID
	 LEFT OUTER JOIN Coupon.CouponCustomerMap CCM
	 ON CC.CouponID=CCM.CouponID
	 where CC.CampaignID=@CampaignID	
	)TempT	
	)Temp	
	WHERE   RowNumber > (@PageCount - 1)*@Size
			ORDER BY RowNumber


END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[SearchCoupons] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[SearchCoupons]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[SearchCoupons] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[SearchCoupons] not created.',16,1)
	END
GO

