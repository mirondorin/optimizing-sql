CREATE FUNCTION get_age(date_of_birth DATE)
RETURNS NUMERIC
AS
$$
BEGIN
    RETURN DATE_PART('year', AGE(date_of_birth));
END;
$$ LANGUAGE plpgsql;