# encoding: utf-8
module ExpansionsHelper
  def rarity_image rarity
    if rarity == :rare_holo
      filename = 'rare'
    else
      filename = rarity.to_s
    end
    (image_tag(filename+'.png')+(rarity == :rare_holo ? 'H' : ''))
  end
  
  def type_symbol type
    if type == :stadium
      symbol = 'St'
    elsif type == :trainer
      symbol = 'T'
    elsif type == :supporter
      symbol = 'Su'
    elsif type == :energy
      symbol = 'E'
    elsif type == :special_energy
      symbol = 'Sp.E'
    else
      symbol = image_tag(type.to_s+'.png')
    end
    symbol
  end
  
  def pop_up_card card
    window_id = card.expansion.name.gsub('é','e').gsub(' ','-').downcase+'_'+card.expansion_order
    image_url = "http://pokebeach.com/scans/#{card.expansion.name.gsub('é','e').gsub(' ','-').downcase}/#{card.expansion_order.downcase}-#{card.name.gsub(' ','-').gsub('é','e').downcase}.jpg"
    link_to card.name, image_url, :onclick => "javascript:open('#{image_url}','#{window_id}','status=no,width=440,height=610');return false;"
  end
  
  def card_row_class card,user
    if(user.id == current_user.id && user.has_card(card))
      return 'is_mine'
    elsif user.has_card(card)
      if current_user.has_card(card)
        return 'is_mine'
      else
        return 'i_need_it'
      end
    else
      return 'doesnt_exist'
    end
  end
  
  def add_remove_card card
    link_to card.expansion_order, (current_user.has_card(card) ? remove_card_path(card.id) : add_card_path(card.id)) , :confirm => 'Are you sure?'
  end
end
