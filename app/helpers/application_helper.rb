module ApplicationHelper
	def calc_unit(product, aliquota)
		number_to_currency(calc(product, aliquota)/product["quantidade_comercializada_produto"].to_i) 
	end
	def calc_total(product, aliquota)
		number_to_currency(calc(product, aliquota)) 
	end

	def calc(product, aliquota)
		if aliquota == "ALIQUOTA_IPI"
			((product["CIF"] + calc(product, "ALIQUOTA_II")) * product["ALIQUOTA_IPI"].gsub(',','.').to_f / 100) 
		else
			(product["CIF"] * product[aliquota].gsub(',','.').to_f / 100)
		end
	end

	def calc_sum_percent(product)
		(product["ALIQUOTA_COFINS_ADVAL"].gsub(',','.').to_f + 
			product["ALIQUOTA_PIS_ADVAL"].gsub(',','.').to_f + 
			product["ALIQUOTA_IPI"].gsub(',','.').to_f +
			product["ALIQUOTA_II"].gsub(',','.').to_f).to_s + "%" 
	end
	def calc_sum_unit(product)
		aliquotas = ["ALIQUOTA_COFINS_ADVAL", "ALIQUOTA_PIS_ADVAL", "ALIQUOTA_IPI", "ALIQUOTA_II" ]
		sum = 0
		aliquotas.each do |aliquota|
			sum += (product["CIF"] * product[aliquota].gsub(',','.').to_f / 100)/product["quantidade_comercializada_produto"].to_i
		end
		number_to_currency(sum)
	end

	def calc_sum_total(product)
		aliquotas = ["ALIQUOTA_COFINS_ADVAL", "ALIQUOTA_PIS_ADVAL", "ALIQUOTA_IPI", "ALIQUOTA_II" ]
		sum = 0
		aliquotas.each do |aliquota|
			sum += (product["CIF"] * product[aliquota].gsub(',','.').to_f / 100)
		end
		number_to_currency(sum)
	end
end
 