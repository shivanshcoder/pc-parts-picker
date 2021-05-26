# For creating facts for the prolog program

import random

instock = {}
category_label = ['gaming', 'casual', 'workbench']
category = {}
cost = {}
compatiblity = {}

# Used for Graphic Cards and Processors
def distributor(card_companies, price_mul):
    cards = []
    for company in card_companies:
        for prefix in card_companies[company][0]:
            for series in card_companies[company][1]:
                for suffix in card_companies[company][2]:
                    cards.append({
                        'name':
                            "{}{}{}{}".format(
                                company, prefix, series, suffix),
                        'category':
                            random.randint(0, 2),
                        'price':
                            (random.randint(1, 10)*price_mul*1000)
                    })
    return cards


def categorize(cards, name):
    instock_temp = []
    for card in cards:

        instock_str = "instock(" + card['name']
        if 'extra_props' in card.keys():
            for props in card['extra_props']:
                instock_str += ",{}".format(props)
        instock_str += ").\n"
        instock_temp.append(instock_str)

    instock[name] = instock_temp

    category[name] = ["category({},\t{},\t{}).\n".format(
        card['name'], name.lower(), category_label[card['category']]) for card in cards]

    cost[name] = ["cost({},\t{}).\n".format(
        card['name'], card['price']) for card in cards]


def random_compatibility(product_list1, product_list2, pair_name):
    compatibility_list = []#"compatible(X, Y) :- compatible_product(Y, X); compatible_product(X, Y).\n"]
    for product1 in product_list1:
        if random.randint(0,1):
            for product2 in product_list2:
                if random.randint(0,1):
                    compatibility_list.append("compatible_product({},\t{}).\n".format(product1['name'], product2['name']))

    compatiblity[pair_name] = compatibility_list

# Graphic Cards

# Graphic card categories
# 1. Casual
# 2. Gaming
# 3. Workbench

# for each entry has a array of graphic_card_name, category, price
graphic_cards = []


graphic_card_companies = {
    'gtx_':
        [[10, 20, 30], [50, 60, 70, 80], [""]],
    'amd_':
        [[2, 3, 4, 5], [300, 400, 600, 700, 800], [""]]

}

graphic_cards = distributor(graphic_card_companies, price_mul=10)

categorize(graphic_cards, 'graphic_card')


# Processors

processors = []

processor_companies = {
    'intel_':
        [['i'], [3, 5, 7, 9], [""]],

    'amd_':
        [['r'], [3, 5, 7, 9], [""]]
}

processors = distributor(processor_companies, price_mul=9)
categorize(processors, 'processor')

# Motherboard

motherboards = []
motherboard_companies = {
    '':
        [['msi_', 'asus_', 'asrock_', 'gigabyte_'], ['A', 'B', 'C'], [10, 20, 30, 40]]
}
motherboards = distributor(motherboard_companies, price_mul=5)
random_compatibility(processors, motherboards, 'processor-motherboard')
categorize(motherboards, 'motherboard')

# Storage
storage = []
storage_comapnies = ['hdd_sata', 'ssd_sata', 'ssd_m2', 'ssd_nvme_m2']

storage_comapnies = {
    'hdd_':
        [ ["sata"], [1,2,4,8], ["TB"]],
    "ssd_":
        [ ["sata", "m2", "nvme_m2"],[125,250, 500, 1000, 2000], ["GB"]]
}

storage = distributor(storage_comapnies, 2)
categorize(storage, 'storage')


# RAM

ram_companies = {
    '':
        [
            ['corsair_', 'gskill_', 'crucial_', 'adata_', 'samsung_', 'kingston_'],
            # [4, 8, 16, 32],
            [2133, 2400, 2666, 2800, 3000, 3200, 3600, 3800, 4133, 4400],
            ["_4GB", "_8GB", "_16GB", "_32GB"]
        ]
}

rams = []

rams = distributor(ram_companies, 3)
random_compatibility(motherboards, rams, 'motherboard-ram')
categorize(rams, "ram")

# ram_limits = {}
# for motherboards

#         for speed in ram_companies['speed']:


# PSU


##################################################


# Contains some part of the code
prolog_code_file = "part_code.pl"
final_file = "final_code.pl"

# Deletes any old data from the file
open(final_file, 'w').close()

# Writing all data to the prolog file


def write_to_file(mydict, main_heading):
    myfile = open(final_file, "a")
    myfile.write("%{}\n\n".format(main_heading))
    for heading in mydict:
        myfile.write("% {}\n".format(heading))
        myfile.writelines(mydict[heading])
        myfile.write("\n\n")
    myfile.close()


#write_to_file(instock, "Stock")
write_to_file(category, "Product Category")
write_to_file(cost, "Cost of Product")
write_to_file(compatiblity, "Compatibility of products")

# Appending rest of the prolog code

myfile = open(final_file, "a")
for line in open(prolog_code_file, "r"):
    myfile.write(line)

myfile.close()
