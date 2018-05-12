/*

	Author:			Manjunathan Raman
	Date created:	01-Oct-2012
	Table Type:		Transactional
	Table Size:		
	Purpose:		To store Valid redemption details
	Usage:			While customer claims data is entered in this table
	Archiving:		

	--Modifications History--
	Changed On		Changed By		Defect Ref		                   Change Description
	14 April 2014    Robin           BI replication Purpose             Ro_No Column Added

*/
IF OBJECT_ID(N'[Coupon].[CouponRedemption]',N'U') IS NULL
	BEGIN

		CREATE TABLE [Coupon].[CouponRedemption](
			[CouponCode] [nvarchar](25) NOT NULL,
			[CustomerID] [bigint] NOT NULL,
			[UTCCreatedDateTime] [smalldatetime] NOT NULL,
			[UTCUpdatedDateTime] [smalldatetime] NOT NULL
		) ON [PRIMARY]
		

		ALTER TABLE [Coupon].[CouponRedemption] ADD  CONSTRAINT [DF_CouponRedemption_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [Coupon].[CouponRedemption] ADD  CONSTRAINT [DF_CouponRedemption_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

		IF OBJECT_ID(N'[Coupon].[CouponRedemption]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CouponRedemption] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[CouponRedemption] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[CouponRedemption] already exists.'
	END
GO

----------------------------- Add Column [Ro_no]-----------------------------------------------------
IF NOT EXISTS(SELECT 1 FROM information_schema.columns      
                           WHERE TABLE_SCHEMA   = 'Coupon'
                           AND TABLE_NAME       = 'CouponRedemption'
                           AND COLUMN_NAME      = 'Ro_No') 
BEGIN  
	ALTER TABLE [Coupon].[CouponRedemption] 
	ADD Ro_No BIGINT IDENTITY(1,1) NOT NULL 
    
    
    ALTER TABLE [Coupon].[CouponRedemption] 
    ADD CONSTRAINT PK_Coupon_CouponRedemption_Ro_No PRIMARY KEY NONCLUSTERED (Ro_No)
     
END
    PRINT 'Column Coupon.CouponRedemption.Ro_No and PK_Coupon_CouponRedemption_Ro_No added to Column Coupon.CouponRedemption.Ro_No'