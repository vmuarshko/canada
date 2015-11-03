package ca1.canadaguaranty;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ScrollView;
import android.widget.Spinner;
import android.widget.TextView;
import ca1.canadaguaranty.R;

public class CalcInsurancePremiumActivity extends BaseActivity {
	public static final class PremiumRange {
		public final double maxLTV;
		public final double premium;

		public PremiumRange(final double maxLTV, final double premium) {
			this.maxLTV = maxLTV;
			this.premium = premium;
		}
	}

	public static final class Product {
		public final String title;
		public final PremiumRange[] premiums;

		public Product(final String title, final PremiumRange[] premiums) {
			this.title = title;
			this.premiums = premiums;
		}

		@Override
		public String toString() {
			return title;
		}
	}

	//
	// Loan-to-Value Ratio Old Premiums NEW Premiums
	// < 65% 0.50% 0.60%
	// 65.01 – 75% 0.65% 0.75%
	// 75.01 – 80% 1.00% 1.25%
	// 80.01 – 85% 1.75% 1.80%
	// 85.01 – 90% 2.00% 2.40%
	// 90.01 – 95% 2.75% 3.15%
	//
	//
	// FLEX 95 ADVANTAGE™
	// Loan-to-Value Ratio Old Premiums NEW Premium
	// 90.01 - 95% 2.90% 3.35%
	//
	//
	// LOW DOC ADVANTAGE™ (Self-Employed)
	// Loan-to-Value Ratio Old Premiums NEW Premiums
	// < 65% 0.80% 0.90%
	// 65.01 – 75% 1.00% 1.15%
	// 75.01 – 80% 1.64% 1.90%
	// 80.01 – 85% 2.90% 3.35%
	// 85.01 – 90% 4.75% 5.45%
	//
	//
	// RENTAL ADVANTAGE™ (1-4 Unit Properties)
	// Loan-to-Value Ratio Old Premiums NEW Premiums
	// < 65% 1.25% 1.45%
	// 65.01 – 75% 1.75% 2.00%
	// 75.01 – 80% 2.50% 2.90%
	//
	// public static final PremiumRange[] STANDARD_PREMIUMS_TABLE_A = new
	// PremiumRange[] {
	// new PremiumRange(65.0, 0.6), new PremiumRange(75.0, 0.75),
	// new PremiumRange(80.0, 1.25), new PremiumRange(85.0, 1.8),
	// new PremiumRange(90.0, 2.4), new PremiumRange(95.0, 3.15), };
	//
	// public static final PremiumRange[] FLEX_55_PREMIUMS_TABLE_B = new
	// PremiumRange[] {
	// new PremiumRange(65.0, 0.5), new PremiumRange(75.0, 0.65),
	// new PremiumRange(80.0, 1.0), new PremiumRange(85.0, 1.75),
	// new PremiumRange(90.0, 2.0), new PremiumRange(95.0, 3.35), };
	//
	// public static final PremiumRange[] LOW_DOC_PREMIUMS_TABLE_C = new
	// PremiumRange[] {
	// new PremiumRange(65.0, 0.9), new PremiumRange(75.0, 1.15),
	// new PremiumRange(80.0, 1.9), new PremiumRange(85.0, 3.35),
	// new PremiumRange(90.0, 5.45), };
	//
	// public static final PremiumRange[] RENTAL_PREMIUMS_TABLE_D = new
	// PremiumRange[] {
	// new PremiumRange(65.0, 1.45), new PremiumRange(75.0, 2.0),
	// new PremiumRange(80.0, 2.9), };

	public static final PremiumRange[] STANDARD_PREMIUMS_TABLE_A = new PremiumRange[] {
			new PremiumRange(65.0, 0.6), new PremiumRange(75.0, 0.75),
			new PremiumRange(80.0, 1.25), new PremiumRange(85.0, 1.8),
			new PremiumRange(90.0, 2.4), new PremiumRange(95.0, 3.60), };

	public static final PremiumRange[] FLEX_55_PREMIUMS_TABLE_B = new PremiumRange[] {
			new PremiumRange(65.0, 0.5), new PremiumRange(75.0, 0.65),
			new PremiumRange(80.0, 1.0), new PremiumRange(85.0, 1.75),
			new PremiumRange(90.0, 2.0), new PremiumRange(95.0, 3.85), };

	public static final PremiumRange[] LOW_DOC_PREMIUMS_TABLE_C = new PremiumRange[] {
			new PremiumRange(65.0, 0.9), new PremiumRange(75.0, 1.15),
			new PremiumRange(80.0, 1.9), new PremiumRange(85.0, 3.35),
			new PremiumRange(90.0, 5.45), };

	public static final PremiumRange[] RENTAL_PREMIUMS_TABLE_D = new PremiumRange[] {
			new PremiumRange(65.0, 1.45), new PremiumRange(75.0, 2.0),
			new PremiumRange(80.0, 2.9), };

	private List<Product> products = null;

	public static final class AmortSurcharge {
		public final int years;
		public final double surcharge;

		public AmortSurcharge(final int years, final double surcharge) {
			this.years = years;
			this.surcharge = surcharge;
		}
	}

	public static final AmortSurcharge[] AMORT_SURCHARGES = new AmortSurcharge[] {
			new AmortSurcharge(25, 0.0), new AmortSurcharge(30, 0.25),
	// new AmortSurcharge(35, 0.4),
	};

	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.calc_insurance_premium);

		initDefaultControls();

		products = new ArrayList<Product>();
		products.add(new Product(getString(R.string.product_standard),
				STANDARD_PREMIUMS_TABLE_A));
		products.add(new Product(getString(R.string.product_flex95),
				FLEX_55_PREMIUMS_TABLE_B));
		products.add(new Product(getString(R.string.product_low_doc),
				LOW_DOC_PREMIUMS_TABLE_C));
		products.add(new Product(getString(R.string.product_rental),
				RENTAL_PREMIUMS_TABLE_D));

		final Spinner spinnerInsuranceType = (Spinner) findViewById(R.id.spinnerInsuranceType);
		if (spinnerInsuranceType != null) {
			ArrayAdapter<Product> adapter = new ArrayAdapter<Product>(this,
					android.R.layout.simple_spinner_item, products);
			adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
			spinnerInsuranceType.setAdapter(adapter);
			spinnerInsuranceType.setSelection(0);
		}

		spinnerInsuranceType
				.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
					@Override
					public void onItemSelected(AdapterView<?> parentView,
							View selectedItemView, int position, long id) {
						Product product = products.get(spinnerInsuranceType
								.getSelectedItemPosition());
						updateAmortSpinner(product.title
								.equals(getString(R.string.product_flex95)));
					}

					@Override
					public void onNothingSelected(AdapterView<?> parentView) {
					}
				});

		Spinner spinnerDollarOrPercent = (Spinner) findViewById(R.id.spinnerDollarOrPercent);
		if (spinnerDollarOrPercent != null) {
			ArrayAdapter<CharSequence> adapter = ArrayAdapter
					.createFromResource(this, R.array.donw_payment_types,
							android.R.layout.simple_spinner_item);
			adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
			spinnerDollarOrPercent.setAdapter(adapter);
			spinnerDollarOrPercent.setSelection(0);
		}

		Spinner spinnerAmortization = (Spinner) findViewById(R.id.spinnerAmortization);
		if (spinnerAmortization != null) {
			ArrayAdapter<CharSequence> adapter = ArrayAdapter
					.createFromResource(this, R.array.loan_periods,
							android.R.layout.simple_spinner_item);
			adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
			spinnerAmortization.setAdapter(adapter);
			spinnerAmortization.setSelection(9);
		}

		Button btnCalc = (Button) findViewById(R.id.btnCalc);
		if (btnCalc != null) {
			btnCalc.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					handleCalc();
				}
			});
		}

		enableBackButton(true);
	}

	private void updateAmortSpinner(boolean isFlex95) {
		Spinner spinnerAmortization = (Spinner) findViewById(R.id.spinnerAmortization);
		if (spinnerAmortization != null) {
			ArrayAdapter<CharSequence> adapter;
			if (isFlex95) {
				adapter = ArrayAdapter.createFromResource(this,
						R.array.loan_periods1,
						android.R.layout.simple_spinner_item);
			} else {
				adapter = ArrayAdapter.createFromResource(this,
						R.array.loan_periods,
						android.R.layout.simple_spinner_item);
			}
			adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
			spinnerAmortization.setAdapter(adapter);
			spinnerAmortization.setSelection(9);
		}
	}

	private void handleCalc() {
		Spinner spinnerDollarOrPercent = (Spinner) findViewById(R.id.spinnerDollarOrPercent);
		Spinner spinnerAmortization = (Spinner) findViewById(R.id.spinnerAmortization);
		Spinner spinnerInsuranceType = (Spinner) findViewById(R.id.spinnerInsuranceType);

		EditText editPurchasePrice = (EditText) findViewById(R.id.editPurchasePrice);
		EditText editDownPayment = (EditText) findViewById(R.id.editDownPayment);

		try {
			int amortizationYears = getResources().getIntArray(
					R.array.loan_period_values)[spinnerAmortization
					.getSelectedItemPosition()] / 12;

			Product product = products.get(spinnerInsuranceType
					.getSelectedItemPosition());

			int downPaymentType = spinnerDollarOrPercent
					.getSelectedItemPosition();

			Double purchasePrice = TextUtils.isEmpty(editPurchasePrice
					.getText().toString().trim()) ? 0.0 : Double
					.parseDouble(editPurchasePrice.getText().toString().trim());
			if (purchasePrice < 100.0 || purchasePrice > 10000000.0) {
				editPurchasePrice.requestFocus();
				throw new Exception(String.format(
						getString(R.string.error_value_in_range), 100.0,
						10000000.0));
			}

			Double downPayment = TextUtils.isEmpty(editDownPayment.getText()
					.toString().trim()) ? 0.0 : Double
					.parseDouble(editDownPayment.getText().toString().trim());

			double minPercent = 1.0;
			double maxPercent = 50.0;

			double minSum = 1.0;
			double maxSum = purchasePrice;

			if (getString(R.string.product_flex95).equals(product.title)) {
				minPercent = 0.1;
				maxPercent = 5.0;

				maxSum = purchasePrice * (maxPercent / 100.0);
			}

			switch (downPaymentType) {
			case 0: /* percent */
				if (downPayment < minPercent || downPayment > maxPercent) {
					editDownPayment.requestFocus();
					throw new Exception(String.format(
							getString(R.string.error_value_in_range),
							minPercent, maxPercent));
				} else {
					downPayment = purchasePrice * (1.0 - (downPayment / 100.0));
				}
				break;

			case 1: /* money */
			{
				if (downPayment < minSum || downPayment > maxSum) {
					editDownPayment.requestFocus();
					throw new Exception(String.format(
							getString(R.string.error_value_in_range), minSum,
							maxSum));
				}
				downPayment = purchasePrice - downPayment;
				break;
			}
			}

			double loanAmount = downPayment;
			double LTV = (downPayment / purchasePrice) * 100.0;
			double premiumRate = findPremiumRate(product, LTV);
			premiumRate += findAmortSurcharge(amortizationYears);

			double premiumAmount = downPayment * (premiumRate / 100.0);

			TextView textPremiumRate = (TextView) findViewById(R.id.textPremiumRate);
			TextView textPremiumAmount = (TextView) findViewById(R.id.textPremiumAmount);
			TextView textLoanAmount = (TextView) findViewById(R.id.textLoanAmount);

			ViewGroup tableResults = (ViewGroup) findViewById(R.id.tableResults);
			textPremiumRate.setText(String.format("%.2f%%", premiumRate));

			// textPremiumAmount.setText(String.format("%s%.2f",
			// getString(R.string.money_sign), premiumAmount));
			textPremiumAmount.setText("$ "
					+ CalcPaymentActivity.formatDouble(premiumAmount));

			// textLoanAmount.setText(String.format("%s%.2f",
			// getString(R.string.money_sign), loanAmount));
			textLoanAmount.setText("$ "
					+ CalcPaymentActivity.formatDouble(loanAmount));

			tableResults.setVisibility(View.VISIBLE);

			InputMethodManager mgr = (InputMethodManager) this
					.getSystemService(Context.INPUT_METHOD_SERVICE);
			mgr.hideSoftInputFromWindow(editPurchasePrice.getWindowToken(), 0);

			editPurchasePrice.requestFocus();
			ScrollView scrollView1 = (ScrollView) findViewById(R.id.scrollView1);
			if (scrollView1 != null) {
				scrollView1.scrollTo(0, 0);
			}
		} catch (NumberFormatException ex) {
			showErrorMessage(getString(R.string.error_number_format));
		} catch (Exception ex) {
			showErrorMessage(ex.getMessage());
		}
	}

	public static double findPremiumRate(final Product product, double LTV) {
		double result = product.premiums[0].premium;
		for (int i = 1; i < product.premiums.length; i++) {
			if (LTV > product.premiums[i - 1].maxLTV
					&& LTV <= product.premiums[i].maxLTV) {
				result = product.premiums[i].premium;
				break;
			}
		}
		if (LTV > product.premiums[product.premiums.length - 1].maxLTV)
			result = product.premiums[product.premiums.length - 1].premium;
		return result;
	}

	private double findAmortSurcharge(final int amortizationYears) {
		double result = AMORT_SURCHARGES[0].surcharge;
		for (int i = 1; i < AMORT_SURCHARGES.length; i++) {
			if (amortizationYears > AMORT_SURCHARGES[i - 1].years
					&& amortizationYears <= AMORT_SURCHARGES[i].years) {
				result = AMORT_SURCHARGES[i].surcharge;
				break;
			}
		}
		if (amortizationYears > AMORT_SURCHARGES[AMORT_SURCHARGES.length - 1].years)
			result = AMORT_SURCHARGES[AMORT_SURCHARGES.length - 1].surcharge;
		return result;
	}
}
