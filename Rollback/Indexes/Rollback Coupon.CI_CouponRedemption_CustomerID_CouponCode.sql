/*
      Created By:       Manjunathan Raman
      Date created:     15 Oct 2012
      Purpose:          ROLLBACK script for CI_CouponRedemption_CustomerID_CouponCode
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
      25 Aug 2011	 Saritha							removed SubscriptionStatus in index	
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'Coupon.CouponRedemption', N'U') 
AND [name] = N'CI_CouponRedemption_CustomerID_CouponCode')
            BEGIN
                        DROP INDEX Coupon.CouponRedemption.[CI_CouponRedemption_CustomerID_CouponCode]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'Coupon.CouponRedemption', N'U') 
                                                            AND [name] = N'CI_CouponRedemption_CustomerID_CouponCode')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [Coupon].[CI_CouponRedemption_CustomerID_CouponCode] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [Coupon].[CI_CouponRedemption_CustomerID_CouponCode] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [Coupon].[CI_CouponRedemption_CustomerID_CouponCode] does not exist.'
            END
GO