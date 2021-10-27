# frozen_string_literal: true

require 'rails_helper'

describe 'Report', type: :request do
  describe 'GET /reports' do
    context 'when call the index of reports' do
      before do
        visitors = create_list(:visitor, 5)
        create(:visitor, store: visitors.first.store)
        create(:visitor, store: visitors.first.store)
        create(:visitor, store: visitors.second.store)
        create(:visitor, store: visitors.second.store)
        create(:visitor, store: visitors.last.store)
        create(:visitor, store: visitors.last.store)

        get reports_path
      end

      it 'returns the report' do
        expect(json[:total_stores]).to eq 5
        expect(json[:stores].size).to eq 5
        expect(json[:stores].pluck(:total_visitors).sum).to eq 11
      end

      it { expect(response).to have_http_status :ok }
    end
  end
end
