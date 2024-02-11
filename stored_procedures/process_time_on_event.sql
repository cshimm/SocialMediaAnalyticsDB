CREATE PROCEDURE `process_time_on_event` ()
BEGIN
    DECLARE v_time_on_event DATETIME;
	DECLARE v_smuid INT;
    -- Take value from column 4 (Time_on_event)
    SELECT time_on_event INTO v_time_on_event
    FROM SM_data_feed;
	
    SELECT SMUID INTO v_smuid
	FROM SM_data_feed;
    
    IF v_time_on_event IS NULL THEN
        SET v_time_on_event = '0000-00-00 00:00:00';
    ELSE
        -- Check if the input is in proper format: 'YYYY-MM-DD hh:mm:ss'
        IF STR_TO_DATE(v_time_on_event, '%Y-%m-%d %H:%i:%s') IS NULL THEN
            -- Check if the input is in date format: 'YYYY-MM-DD'
            IF STR_TO_DATE(v_time_on_event, '%Y-%m-%d') IS NOT NULL THEN
                -- If it matches date format, insert into proper field
                 UPDATE SM_data_feed SET time_on_event = v_time_on_event
                 WHERE SMUID = v_smuid;
            ELSE
                -- If not in any discernible format, just disregard date
                SET v_time_on_event = NULL;
            END IF;
        ELSE
                 UPDATE SM_data_feed SET time_on_event = v_time_on_event
                 WHERE SMUID = v_smuid;
        END IF;
    END IF;
END 