MONTHS_PER_YEAR = 12

##### Home Energy: Fuel Oil #####
## Constants
FUEL_OIL_AVG_PRICE_PER_GALLON = 4.02           # Dollars per gallon
FUEL_OIL_EMISSION_FACTOR = 22.61               # lbs CO2 / gallon of fuel oil
FUEL_OIL_AVG_EMISSION_PER_YEAR_PERSON = 4848   # lbs CO2/year/person

## Formulas
def calculate_emission_for_fuel_oil(consumption_type, input):
    '''
    Calculates the amount of emissions produced by using fuel oil

    Total Emissions = Gallons Per Month * 12 * FUEL_OIL_EMISSION_FACTOR
    '''
    if consumption_type != 'Gallons' and consumption_type != 'Dollars':
        raise ValueError("Consumption type should be 'Gallons' or 'Dollars'")

    if consumption_type == 'Gallons':
        gallons_per_month = input
    else:
        gallons_per_month = input / FUEL_OIL_AVG_PRICE_PER_GALLON

    return gallons_per_month * FUEL_OIL_EMISSION_FACTOR * MONTHS_PER_YEAR

def build_expected_text_for_fuel_oil_emissions(consumption_type, input):
    '''
    Builds text representing english formatted number of fuel oil emissions given consumption type and value

    Parameters
    ----------
    consumption_type : string
        For fuel oil it can be 'Dollars' or 'Gallons'
    input : int
        Amount of fuel oil consumed in the given consumption type unit

    Raises
    ------
    ValueError
        If the consumption_type is neither 'Dollars' nor 'Gallons'

    Returns
    -------
    expected_text : string
        fuel_oil_emissions, formatted (Ex: 8,200)
    '''
    fuel_oil_emissions = round(calculate_emission_for_fuel_oil(consumption_type, input))
    expected_text = format(fuel_oil_emissions, ',')

    return expected_text

def build_expected_text_for_us_average_fuel_oil_emissions():
    '''
    Builds text representing english formatted number of average US fuel oil emissions for household

    Returns
    -------
    expected_text : string
        FUEL_OIL_AVG_EMISSION_PER_YEAR_PERSON, formatted (Ex: 8,200)
    '''
    expected_text = format(FUEL_OIL_AVG_EMISSION_PER_YEAR_PERSON, ',')
    return expected_text

##### Waste: Current Emissions #####
## Constants
WASTE_AVG_PER_YEAR_PERSON = 692
METAL_AVG_RECYCLED_SAVED = 89
PLASTIC_AVG_RECYCLED_SAVED = 36
GLASS_AVG_RECYCLED_SAVED = 25
NEWSPAPER_AVG_RECYCLED_SAVED = 113
MAGAZINES_AVG_RECYCLED_SAVED = 27

## Formulas
def get_saved_amount_by_recycled_material(recycled_material):
    '''
    Returns the average amount of emissions that is saved by recycling a given material
    '''
    match recycled_material:
        case 'aluminum':
            return METAL_AVG_RECYCLED_SAVED
        case 'plastic':
            return PLASTIC_AVG_RECYCLED_SAVED
        case 'glass':
            return GLASS_AVG_RECYCLED_SAVED
        case 'newspaper':
            return NEWSPAPER_AVG_RECYCLED_SAVED
        case 'magazines':
            return MAGAZINES_AVG_RECYCLED_SAVED
        case _:
            raise ValueError('Invalid recycled material')

def build_expected_text_for_waste_emissions_after_recycling(recycled_material):
    '''
    Builds text representing english formatted number of waste emissions after recycling a single material.

    Parameters
    ----------
    recycled_material : string
        Can be 'aluminum', 'plastic', 'glass', 'newspaper', or 'magazines'

    Raises
    ------
    ValueError
        If the recycled_material argument is not one of the valid values

    Returns
    -------
    expected_text : string
        total_emissions - saved_emissions, formatted (Ex: 8,200)
    '''
    total_emissions = WASTE_AVG_PER_YEAR_PERSON
    saved = get_saved_amount_by_recycled_material(recycled_material)

    expected_text = format(total_emissions - saved, ',')
    return expected_text


def build_expected_text_for_us_average_recycled_waste_emissions():
    '''
    Builds text representing english formatted number of average US waste emissions for a single person

    Returns
    -------
    expected_text : string
        WASTE_AVG_PER_YEAR_PERSON, formatted (Ex: 8,200)
    '''
    expected_text = format(WASTE_AVG_PER_YEAR_PERSON, ',')
    return expected_text

##### Transportation #####
AVG_EMISSION_PER_VEHICLE = 10484                                                                   # lbs of CO2/vehicle
DECREASED_EFFICIENCY_NO_MAINTENANCE = 1.04                                                         # %
INCREASE_EFFICIENCY_FULL_MAINTENANCE = 0.07                                                        # %
EMISSION_PER_GALLON = 19.6                                                                         # lbs of CO2/gallon
RATIO_OF_EMISSIONS = 100 / 98.65                                                                   # lbs of CO2e/lbs of CO2
AVG_COST_PER_GALLON = 3.68                                                                         # dollars/gallon
AVG_COST_PER_POUND_EMISSION = AVG_COST_PER_GALLON / (EMISSION_PER_GALLON * RATIO_OF_EMISSIONS)     # dollars/lbs of CO2e


def calculate_total_emission_for_vehicle_with_current_maintenance(miles, gas_mileage):
    '''
    Calculates the number of gallons per year, multiplied by the emission of CO2 per gallon,
    and finally multiply by the ratio between greenhouse gases and CO2 (to consider all gases)

    Total Emission With Maintenance = (gallons_per_year) * EMISSION_PER_GALLON * RATIO_OF_EMISSIONS
    '''
    gallons_per_year = miles / gas_mileage
    emissions = EMISSION_PER_GALLON * RATIO_OF_EMISSIONS * gallons_per_year

    return emissions

def calculate_saved_emissions(miles, gas_mileage):
    '''
    Calculates the number of saved emissions by taking the total emission with maintenance, and multiplying by
    the percentage that represents the full efficiency improvement that happened due to the maintenance (Ex: 7%)

    Saved Emissions = Total Emission With Maintenance * INCREASE_EFFICIENCY_FULL_MAINTENANCE
    '''
    emissions = calculate_total_emission_for_vehicle_with_current_maintenance(miles, gas_mileage)
    return emissions * INCREASE_EFFICIENCY_FULL_MAINTENANCE

def calculate_saved_money(miles, gas_mileage):
    ''' 
    Calculates the amount of money saved by doing maintenance, done by taking the saved emissions with maintenance
    and multiplying it by Cost Per Gallon, dividing everything by Emission Per Gallon to find the Cost By Emission
        
    Cost = Saved Emissions * AVG_COST_PER_POUND_EMISSION 
    '''
    saved_emissions = calculate_saved_emissions(miles, gas_mileage)

    return round(saved_emissions) * AVG_COST_PER_POUND_EMISSION

def calculate_total_emission_for_vehicle_without_current_maintenance(miles, gas_mileage):
    '''
    Calculates the total emission for a vehicle without maintenance, doing so by getting how much is emitted by a vehicle
    with maintenance and then applying the Decreased Efficiency percentage

    Total Emission Without Maintenance = Total Emission With Maintenance * DECREASED_EFFICIENCY_NO_MAINTENANCE
    '''
    emissions = calculate_total_emission_for_vehicle_with_current_maintenance(miles, gas_mileage) * DECREASED_EFFICIENCY_NO_MAINTENANCE

    return emissions

def build_expected_text_for_saved_emissions_with_maintenance(miles, gas_mileage):
    '''
    Builds text representing english formatted number of saved emissions by doing maintenance to a vehicle

    Parameters
    ----------
    miles : int
        Miles driven (assuming option selected is Per Year)
    gas_mileage : int
        Miles per gallon

    Returns
    -------
    expected_text : string
        saved_emissions, formatted (Ex: 8,200)
    '''
    saved_emissions = calculate_saved_emissions(miles, gas_mileage)
    saved_emissions = round(saved_emissions)
    expected_text = format(saved_emissions, ',')

    return expected_text

def build_expected_text_for_saved_money_with_maintenance(miles, gas_mileage):
    '''
    Builds text representing english formatted number of saved money by doing maintenance to a vehicle

    Parameters
    ----------
    miles : int
        Miles driven (assuming option selected is Per Year)
    gas_mileage : int
        Miles per gallon

    Returns
    -------
    expected_text : string
        saved_money, formatted (Ex: 8,200)
    '''
    saved_money = calculate_saved_money(miles, gas_mileage)
    saved_money = round(saved_money)
    expected_text = format(saved_money, ',')

    return expected_text

def build_expected_text_for_total_emission_for_vehicle_with_maintenance(miles, gas_mileage):
    '''
    Builds text representing english formatted number of total emissions for a vehicle that had maintenance

    Parameters
    ----------
    miles : int
        Miles driven (assuming option selected is Per Year)
    gas_mileage : int
        Miles per gallon

    Returns
    -------
    expected_text : string
        emissions_without_maintenance - saved_emissions, formatted (Ex: 8,200)
    '''
    emissions_without_maintenance = calculate_total_emission_for_vehicle_without_current_maintenance(miles, gas_mileage)
    saved_emissions = calculate_saved_emissions(miles, gas_mileage)

    new_total = round(emissions_without_maintenance - saved_emissions)
    expected_text = format(new_total, ',')

    return expected_text

def build_expected_text_for_total_emission_for_vehicle_without_maintenance(miles, gas_mileage):
    '''
    Builds text representing english formatted number of total emission produced by a vehicle without maintenance

    Parameters
    ----------
    miles : int
        Miles driven (assuming option selected is Per Year)
    gas_mileage : int
        Miles per gallon

    Returns
    -------
    expected_text : string
        emissions_without_maintenance, formatted (Ex: 8,200)
    '''
    emissions_without_maintenance = calculate_total_emission_for_vehicle_without_current_maintenance(miles, gas_mileage)
    emissions_without_maintenance = round(emissions_without_maintenance)

    expected_text = format(emissions_without_maintenance, ',')
    return expected_text

def build_expected_text_for_us_average_for_vehicle():
    '''
    Builds text representing english formatted number of average US vehicle emissions

    Returns
    -------
    expected_text : string
        AVG_EMISSION_PER_VEHICLE, formatted (Ex: 8,200)
    '''
    expected_text = format(AVG_EMISSION_PER_VEHICLE, ',')
    return expected_text