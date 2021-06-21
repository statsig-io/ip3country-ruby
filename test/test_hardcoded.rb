require 'minitest'
require 'minitest/autorun'
require 'country_lookup'

class TestHardcoded < Minitest::Test

  def before_setup
    super
    CountryLookup.initialize
  end

  def test_ip3country_hardcoded
    assert (CountryLookup.lookup_ip_string('1.1.1.1') == 'US')
    assert (CountryLookup.lookup_ip_string('2.2.2.2') == 'FR')
    assert (CountryLookup.lookup_ip_string('3.3.3.3') == 'US')
    assert (CountryLookup.lookup_ip_string('4.4.4.4') == 'US')
    assert (CountryLookup.lookup_ip_string('5.5.5.5') == 'DE')
    assert (CountryLookup.lookup_ip_string('6.6.6.6') == 'US')
    assert (CountryLookup.lookup_ip_string('7.7.7.7') == 'US')
    assert (CountryLookup.lookup_ip_string('8.8.8.8') == 'US')
    assert (CountryLookup.lookup_ip_string('9.9.9.9') == 'US')
    assert (CountryLookup.lookup_ip_string('11.11.11.11') == 'US')
    assert (CountryLookup.lookup_ip_string('12.12.12.12') == 'US')
    assert (CountryLookup.lookup_ip_string('13.13.13.13') == 'US')
    assert (CountryLookup.lookup_ip_string('14.14.14.14') == 'JP')
    assert (CountryLookup.lookup_ip_string('15.15.15.15') == 'US')
    assert (CountryLookup.lookup_ip_string('16.16.16.16') == 'US')
    assert (CountryLookup.lookup_ip_string('17.17.17.17') == 'US')
    assert (CountryLookup.lookup_ip_string('18.18.18.18') == 'US')
    assert (CountryLookup.lookup_ip_string('19.19.19.19') == 'US')
    assert (CountryLookup.lookup_ip_string('20.20.20.20') == 'US')
    assert (CountryLookup.lookup_ip_string('21.21.21.21') == 'US')
    assert (CountryLookup.lookup_ip_string('22.22.22.22') == 'US')
    assert (CountryLookup.lookup_ip_string('23.23.23.23') == 'US')
    assert (CountryLookup.lookup_ip_string('24.24.24.24') == 'US')
    assert (CountryLookup.lookup_ip_string('25.25.25.25') == 'GB')
    assert (CountryLookup.lookup_ip_string('26.26.26.26') == 'US')
    assert (CountryLookup.lookup_ip_string('27.27.27.27') == 'CN')
    assert (CountryLookup.lookup_ip_string('28.28.28.28') == 'US')
    assert (CountryLookup.lookup_ip_string('29.29.29.29') == 'US')
    assert (CountryLookup.lookup_ip_string('30.30.30.30') == 'US')
    assert (CountryLookup.lookup_ip_string('31.31.31.31') == 'MD')
    assert (CountryLookup.lookup_ip_string('41.41.41.41') == 'EG')
    assert (CountryLookup.lookup_ip_string('42.42.42.42') == 'KR')
    assert (CountryLookup.lookup_ip_string('45.45.45.45') == 'CA')
    assert (CountryLookup.lookup_ip_string('46.46.46.46') == 'RU')
    assert (CountryLookup.lookup_ip_string('49.49.49.49') == 'TH')
    assert (CountryLookup.lookup_ip_string('101.101.101.101') == 'TW')
    assert (CountryLookup.lookup_ip_string('110.110.110.110') == 'CN')
    assert (CountryLookup.lookup_ip_string('111.111.111.111') == 'JP')
    assert (CountryLookup.lookup_ip_string('112.112.112.112') == 'CN')
    assert (CountryLookup.lookup_ip_string('150.150.150.150') == 'KR')
    assert (CountryLookup.lookup_ip_string('200.200.200.200') == 'BR')
    assert (CountryLookup.lookup_ip_string('202.202.202.202') == 'CN')
    assert (CountryLookup.lookup_ip_string('45.85.95.65') == 'CH')
    assert (CountryLookup.lookup_ip_string('58.96.74.25') == 'AU')
    assert (CountryLookup.lookup_ip_string('88.99.77.66') == 'DE')
    assert (CountryLookup.lookup_ip_string('25.67.94.211') == 'GB')
    assert (CountryLookup.lookup_ip_string('27.67.94.211') == 'VN')
    assert (CountryLookup.lookup_ip_string('27.62.93.211') == 'IN')
  end
end