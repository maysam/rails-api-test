# frozen_string_literal: true

require 'spec_helper'

shared_examples_for 'expirable' do
  let(:model) { described_class }

  context '#expired?' do
    before do
      Timecop.freeze('2019-01-01')
    end

    after do
      Timecop.return
    end

    context 'expiration_date is in the past' do
      subject { build(model.to_s.underscore.to_sym, expiration_date: '2018-12-31') }

      it { expect(subject.expired?).to be_truthy }
    end

    context 'expiration_date is in the present' do
      subject { build(model.to_s.underscore.to_sym, expiration_date: '2019-01-01') }

      it { expect(subject.expired?).to be_falsey }
    end

    context 'expiration_date is in the future' do
      subject { build(model.to_s.underscore.to_sym, expiration_date: '2019-01-02') }

      it { expect(subject.expired?).to be_falsey }
    end
  end
end
