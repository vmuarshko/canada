package ca1.canadaguaranty;

import java.util.ArrayList;
import java.util.List;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ScrollView;
import android.widget.Spinner;
import android.widget.TableRow;
import android.widget.TextView;
import ca1.canadaguaranty.CalcInsurancePremiumActivity.Product;

public class CalcPaymentActivity extends BaseActivity {
	private List<Product> products = null;

	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.calc_payment);

		initDefaultControls();

		Spinner spinnerDownPayment = (Spinner) findViewById(R.id.spinnerDownPayment);
		if (spinnerDownPayment != null) {
			ArrayAdapter<CharSequence> adapter = ArrayAdapter
					.createFromResource(this, R.array.donw_payments,
							android.R.layout.simple_spinner_item);
			adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
			spinnerDownPayment.setAdapter(adapter);

			spinnerDownPayment
					.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
						@Override
						public void onItemSelected(AdapterView<?> parentView,
								View selectedItemView, int position, long id) {
							updateIncProducts((position + 1) * 5);
							updateMortgageAmount(false);
						}

						@Override
						public void onNothingSelected(AdapterView<?> parentView) {
						}
					});
			spinnerDownPayment.setSelection(0);
		}

		Spinner spinnerTerm = (Spinner) findViewById(R.id.spinnerTerm);
		if (spinnerTerm != null) {
			ArrayAdapter<CharSequence> adapter = ArrayAdapter
					.createFromResource(this, R.array.comparision_periods,
							android.R.layout.simple_spinner_item);
			adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
			spinnerTerm.setAdapter(adapter);
			spinnerTerm.setSelection(4);
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

					updateMortgageAmount(true);
					final ScrollView scrollview = ((ScrollView) findViewById(R.id.scrollView1));
					scrollview.post(new Runnable() {
						@Override
						public void run() {
							scrollview.fullScroll(ScrollView.FOCUS_DOWN);
						}
					});
					// handleCalc();
				}
			});
		}

		EditText editPurchasePrice = (EditText) findViewById(R.id.editPurchasePrice);
		editPurchasePrice
				.setOnFocusChangeListener(new EditText.OnFocusChangeListener() {
					@Override
					public void onFocusChange(View v, boolean hasFocus) {
						if (!hasFocus)
							updateMortgageAmount(false);
					}
				});

		// EditText editDownPayment = (EditText)
		// findViewById(R.id.editDownPayment);
		// editDownPayment.setOnFocusChangeListener(new
		// EditText.OnFocusChangeListener()
		// {
		// @Override
		// public void onFocusChange(View v, boolean hasFocus)
		// {
		// if (!hasFocus) updateMortgageAmount();
		// }
		// });

		enableBackButton(true);

	}

	private void updateIncProducts(int downPaymentvalue) {
		final Spinner spinnerInsuranceProduct = (Spinner) findViewById(R.id.spinnerInsuranceProduct);
		products = new ArrayList<Product>();

		if (downPaymentvalue == 5) {
			products.add(new Product(
					getString(R.string.product_standard),
					ca1.canadaguaranty.CalcInsurancePremiumActivity.STANDARD_PREMIUMS_TABLE_A));
			products.add(new Product(
					getString(R.string.product_flex95),
					ca1.canadaguaranty.CalcInsurancePremiumActivity.FLEX_55_PREMIUMS_TABLE_B));
		} else if (downPaymentvalue == 10 || downPaymentvalue == 15) {
			products.add(new Product(
					getString(R.string.product_standard),
					ca1.canadaguaranty.CalcInsurancePremiumActivity.STANDARD_PREMIUMS_TABLE_A));
			products.add(new Product(
					getString(R.string.product_low_doc),
					ca1.canadaguaranty.CalcInsurancePremiumActivity.LOW_DOC_PREMIUMS_TABLE_C));
		} else if (downPaymentvalue >= 20 && downPaymentvalue <= 85) {
			products.add(new Product(
					getString(R.string.product_standard),
					ca1.canadaguaranty.CalcInsurancePremiumActivity.STANDARD_PREMIUMS_TABLE_A));
			products.add(new Product(
					getString(R.string.product_low_doc),
					ca1.canadaguaranty.CalcInsurancePremiumActivity.LOW_DOC_PREMIUMS_TABLE_C));
			products.add(new Product(
					getString(R.string.product_rental),
					ca1.canadaguaranty.CalcInsurancePremiumActivity.RENTAL_PREMIUMS_TABLE_D));
		} else if (downPaymentvalue == 90 || downPaymentvalue == 95) {
			products.add(new Product(
					getString(R.string.product_standard),
					ca1.canadaguaranty.CalcInsurancePremiumActivity.STANDARD_PREMIUMS_TABLE_A));
			products.add(new Product(
					getString(R.string.product_low_doc),
					ca1.canadaguaranty.CalcInsurancePremiumActivity.LOW_DOC_PREMIUMS_TABLE_C));
		} else if (downPaymentvalue == 100) {
			products.add(new Product(
					getString(R.string.product_standard),
					ca1.canadaguaranty.CalcInsurancePremiumActivity.STANDARD_PREMIUMS_TABLE_A));
		}
		ArrayAdapter<Product> adapter = new ArrayAdapter<Product>(this,
				android.R.layout.simple_spinner_item, products);
		adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		spinnerInsuranceProduct.setAdapter(adapter);
		spinnerInsuranceProduct.setSelection(0);
		spinnerInsuranceProduct
				.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
					@Override
					public void onItemSelected(AdapterView<?> parentView,
							View selectedItemView, int position, long id) {
						Product product = products.get(spinnerInsuranceProduct
								.getSelectedItemPosition());
						updateAmortSpinner(product.title
								.equals(getString(R.string.product_flex95)));
						updateMortgageAmount(false);
					}

					@Override
					public void onNothingSelected(AdapterView<?> parentView) {
					}
				});
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

	private void updateMortgageAmount(boolean finalCalc) {

		EditText editPurchasePrice = (EditText) findViewById(R.id.editPurchasePrice);
		Spinner spinnerDownPayment = (Spinner) findViewById(R.id.spinnerDownPayment);
		Spinner spinnerInsuranceProduct = (Spinner) findViewById(R.id.spinnerInsuranceProduct);
		TextView initialMortgageAmount = (TextView) findViewById(R.id.initialMortgageAmount);
		TextView textPremiumRate = (TextView) findViewById(R.id.textPremiumRate);
		TextView textPremiumAmount = (TextView) findViewById(R.id.textPremiumAmount);
		TextView textTotalMortgageAmount = (TextView) findViewById(R.id.textTotalMortgageAmount);
		Spinner spinnerAmortization = (Spinner) findViewById(R.id.spinnerAmortization);
		Spinner spinnerTerm = (Spinner) findViewById(R.id.spinnerTerm);
		EditText editMortgageRate = (EditText) findViewById(R.id.editMortgageRate);

		TextView textMonthly = (TextView) findViewById(R.id.textMonthly);
		TextView textBiWeeklyAccelerated = (TextView) findViewById(R.id.textBiWeeklyAccelerated);
		TextView textWeeklyAccelerated = (TextView) findViewById(R.id.textWeeklyAccelerated);

		TableRow divider1 = (TableRow) findViewById(R.id.divider1);
		TableRow divider2 = (TableRow) findViewById(R.id.divider2);
		try {
			String strPurchasePrice = editPurchasePrice.getText().toString()
					.trim();
			Double purchasePrice = TextUtils.isEmpty(strPurchasePrice) ? 0.0
					: Double.parseDouble(strPurchasePrice);
			String strMortgageRate = editMortgageRate.getText().toString()
					.trim();
			Double mortgageRate = TextUtils.isEmpty(strMortgageRate) ? 0.0
					: Double.parseDouble(editMortgageRate.getText().toString()
							.trim());

			if (finalCalc) {
				if (purchasePrice < 100.0 || purchasePrice > 10000000.0) {
					editPurchasePrice.requestFocus();
					// throw new Exception(String.format(
					// getString(R.string.error_value_in_range), 100.0,
					// 10000000.0));
					throw new Exception(getString(R.string.error_values));
				}
				if (mortgageRate <= 0.1 || mortgageRate > 30.0) {
					editMortgageRate.requestFocus();
					// throw new Exception(
					// String.format(
					// getString(R.string.error_value_in_range),
					// 0.1, 30.0));
					throw new Exception(getString(R.string.error_values));
				}
				((View) textMonthly.getParent()).setVisibility(View.VISIBLE);
				((View) textBiWeeklyAccelerated.getParent())
						.setVisibility(View.VISIBLE);
				((View) textWeeklyAccelerated.getParent())
						.setVisibility(View.VISIBLE);
				divider1.setVisibility(View.VISIBLE);
				divider2.setVisibility(View.VISIBLE);
			} else {
				((View) textMonthly.getParent()).setVisibility(View.GONE);
				((View) textBiWeeklyAccelerated.getParent())
						.setVisibility(View.GONE);
				((View) textWeeklyAccelerated.getParent())
						.setVisibility(View.GONE);
				divider1.setVisibility(View.GONE);
				divider2.setVisibility(View.GONE);

			}

			Double mortgageAmount = purchasePrice;

			Double downPayment = (spinnerDownPayment.getSelectedItemPosition() + 1) * 5.0;
			mortgageAmount = purchasePrice
					- (purchasePrice * (downPayment / 100.0));

			if (!TextUtils.isEmpty(strPurchasePrice)) {
				// initialMortgageAmount.setText(String.format("%.2f",
				// mortgageAmount));
				initialMortgageAmount.setText("$ "
						+ formatDouble(mortgageAmount));
			}

			if (products.size() > 0) {
				Product product = products.get(spinnerInsuranceProduct
						.getSelectedItemPosition());
				double premRate = ca1.canadaguaranty.CalcInsurancePremiumActivity
						.findPremiumRate(product, 100 - downPayment);

				int term = getResources().getIntArray(
						R.array.comparision_periods)[spinnerTerm
						.getSelectedItemPosition()];

				if ((term > 25) && (term <= 30))
					premRate = premRate + 0.25;
				else if ((term > 30) && (term <= 35))
					premRate = premRate + 0.4;

				int amortizationMonths = getResources().getIntArray(
						R.array.loan_period_values)[spinnerAmortization
						.getSelectedItemPosition()];
				if (amortizationMonths == 360)
					premRate = premRate + 0.25;

				textPremiumRate.setText(String.format("%.2f", premRate) + "%");

				double premiumAmt = (mortgageAmount * premRate) / 100;

				textPremiumAmount.setText("$ " + formatDouble(premiumAmt));

				double amt = premiumAmt + mortgageAmount; // mcPrice
				textTotalMortgageAmount.setText("$ " + formatDouble(amt));

				double itwoval = Math.pow((1 + mortgageRate / 200), 0.16666667);
				Log.d("itwoval", itwoval + "");
				double payamt = (amt * (itwoval - 1) / (1 - (Math.pow(itwoval,
						-(amortizationMonths)))));
				Log.d("payamt", payamt + "");
				if (payamt > 0) {
					// textMonthly.setText("$ " + String.format("%.2f",
					// payamt));
					textMonthly.setText("$ " + formatDouble(payamt));
					payamt = payamt / 2;
					// textBiWeeklyAccelerated.setText("$ "
					// + String.format("%.2f", payamt));
					textBiWeeklyAccelerated
							.setText("$ " + formatDouble(payamt));
					payamt = payamt / 2;
					// textWeeklyAccelerated.setText("$ "
					// + String.format("%.2f", payamt));
					textWeeklyAccelerated.setText("$ " + formatDouble(payamt));

				} else {
					textMonthly.setText("$ 0.00");
					textBiWeeklyAccelerated.setText("$ 0.00");
					textWeeklyAccelerated.setText("$ 0.00");
				}

			}
			// double finalLoadAmt;
			//
			// finalLoadAmt = purchasePrice - round(purchasePrice * downPay /
			// 100);
			//
			// loanAmt = finalLoadAmt;
			//
			// //type rate(LVR) amort(term)
			// NSString *strInsType = [arrMortgageValue objectAtIndex:3];
			// double insRate = downPay;
			// double amortTerm = [[[arrMortgageValue objectAtIndex:9]
			// substringToIndex:2] doubleValue];
			//
			// //Premium rate
			// double singlePrem = [self getSinglePre:strInsType :insRate
			// :amortTerm];
			//
			// //premium amount //loanamount * singlepremium / 100
			// double premiumAmt = (finalLoadAmt * singlePrem) / 100;
			//
			//
			// double amt = premiumAmt + loanAmt; //mcPrice
			// double rate = [[arrMortgageValue objectAtIndex:7] doubleValue];
			// //mcRate
			// double years = [[[arrMortgageValue objectAtIndex:9]
			// substringToIndex:2] doubleValue]; //mcAmort
			//
			// double itwoval = pow((1+ rate/200), 0.16666667);
			// double payamt = (amt * (itwoval -1) / (1 - (pow(itwoval,
			// -(years*12)))));

			// NSString *str = @"%";
			// [arrMortgageValue replaceObjectAtIndex:4 withObject:[NSString
			// stringWithFormat:@"%.2f %@", premRate, str]];
			//
			// [arrMortgageValue replaceObjectAtIndex:5 withObject:[NSString
			// stringWithFormat:@"$ %.2f", premAmt]];
			// [arrMortgageValue replaceObjectAtIndex:6 withObject:[NSString
			// stringWithFormat:@"$ %.2f", premAmt + loanAmt]];

		} catch (NumberFormatException ex) {
			showErrorAlert(getString(R.string.error_number_format));
		} catch (Exception ex) {
			showErrorAlert(ex.getMessage());
		}
	}

	private void showErrorAlert(String message) {
		new AlertDialog.Builder(this)
				.setTitle(R.string.invalid_title)
				.setMessage(message)
				.setPositiveButton(android.R.string.ok,
						new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface dialog,
									int which) {
								dialog.dismiss();
							}
						}).show();
	}

	public static String formatDouble(double sum) {
		// Turn random double into a clean currency format (ie 2 decimal places)
		StringBuffer result;

		if (Math.abs(sum) < .01) {
			result = new StringBuffer("0.00");
		} else {
			if (sum > 0)
				sum = sum + 0.005;
			else
				sum = sum - 0.005;
			result = new StringBuffer(Double.toString(sum));
			final int point = result.toString().indexOf('.');
			if (point > 0) {
				if (point < (result.length() - 2)) {
					result = new StringBuffer(result.toString().substring(0,
							point + 3));
				}
				for (int i = point - 3; i > 0; i -= 3) {
					result = new StringBuffer(result.toString().substring(0, i)
							+ ","
							+ result.toString().substring(i, result.length()));
				}

			}

		}
		return result.toString();
	}

}
